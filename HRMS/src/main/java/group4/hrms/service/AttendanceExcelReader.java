package group4.hrms.service;

import java.io.InputStream;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellValue;
import org.apache.poi.ss.usermodel.DateUtil;
import org.apache.poi.ss.usermodel.FormulaEvaluator;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import group4.hrms.entity.Attendance;
import group4.hrms.repository.AttendanceRepository;

public class AttendanceExcelReader {

    private static final DateTimeFormatter dateTimeFormatter = DateTimeFormatter.ofPattern("dd/MM/yyyy H:mm");

    // Đọc file Excel trả về List<Attendance> (Preview)
    public static List<Attendance> readFromExcel(InputStream inputStream) throws Exception {
        List<Attendance> result = new ArrayList<>();

        Workbook workbook = new XSSFWorkbook(inputStream);
        Sheet sheet = workbook.getSheetAt(0);

        for (int i = 1; i <= sheet.getLastRowNum(); i++) {
            Row row = sheet.getRow(i);
            if (row == null) {
                continue;
            }

            try {
                String userIdStr = getCellValueAsString(row.getCell(0));
                String checkType = getCellValueAsString(row.getCell(1));
                String checkedAtStr = getCellValueAsString(row.getCell(2));
                String source = getCellValueAsString(row.getCell(3));
                String note = getCellValueAsString(row.getCell(4));
                String periodIdStr = getCellValueAsString(row.getCell(5));

                if (userIdStr.isEmpty()) {
                    throw new IllegalArgumentException("user_id trống tại dòng " + (i + 1));
                }
                Long userId = Long.valueOf(userIdStr);
                Long periodId = periodIdStr.isEmpty() ? null : Long.valueOf(periodIdStr);
                LocalDateTime checkedAt = parseCheckedAt(checkedAtStr);

                Attendance attendance = new Attendance();
                attendance.setUserId(userId);
                attendance.setCheckType(checkType);
                attendance.setCheckedAt(checkedAt);
                attendance.setSource(source.isEmpty() ? null : source);
                attendance.setNote(note.isEmpty() ? null : note);
                attendance.setPeriodId(periodId);

                result.add(attendance);

            } catch (IllegalArgumentException e) {
                System.err.println("Lỗi tại dòng " + (i + 1) + ": " + e.getMessage());
            }
        }

        workbook.close();
        return result;
    }

    // Lưu vào DB
    public static void saveToDB(List<Attendance> data) throws Exception {
        AttendanceRepository repo = new AttendanceRepository();
        for (Attendance att : data) {
            repo.saveImportAttendance(att);
        }
    }

    // Convert cell → String
    private static String getCellValueAsString(Cell cell) {
        if (cell == null) {
            return "";
        }
        switch (cell.getCellType()) {
            case STRING:
                return cell.getStringCellValue().trim();
            case NUMERIC:
                if (DateUtil.isCellDateFormatted(cell)) {
                    return cell.getDateCellValue().toInstant()
                            .atZone(java.time.ZoneId.systemDefault())
                            .toLocalDateTime()
                            .format(dateTimeFormatter);
                } else {
                    double val = cell.getNumericCellValue();
                    return val % 1 == 0 ? String.valueOf((long) val) : String.valueOf(val);
                }
            case BOOLEAN:
                return String.valueOf(cell.getBooleanCellValue());
            case FORMULA:
                FormulaEvaluator evaluator = cell.getSheet().getWorkbook().getCreationHelper().createFormulaEvaluator();
                CellValue cellValue = evaluator.evaluate(cell);
                switch (cellValue.getCellType()) {
                    case STRING:
                        return cellValue.getStringValue().trim();
                    case NUMERIC:
                        double val = cellValue.getNumberValue();
                        return val % 1 == 0 ? String.valueOf((long) val) : String.valueOf(val);
                    case BOOLEAN:
                        return String.valueOf(cellValue.getBooleanValue());
                    default:
                        return "";
                }
            default:
                return "";
        }
    }

    private static LocalDateTime parseCheckedAt(String checkedAtStr) {
        checkedAtStr = checkedAtStr.trim();
        if (checkedAtStr.isEmpty()) {
            throw new IllegalArgumentException("checked_at trống");
        }

        try {
            return LocalDateTime.parse(checkedAtStr, dateTimeFormatter);
        } catch (Exception e) {
            if (checkedAtStr.matches("\\d{1,2}:\\d{2}(:\\d{2})?")) {
                String[] parts = checkedAtStr.split(":");
                int hour = Integer.parseInt(parts[0]);
                int minute = Integer.parseInt(parts[1]);
                return LocalDate.now().atTime(hour, minute);
            } else {
                throw new IllegalArgumentException("checked_at không hợp lệ: " + checkedAtStr);
            }
        }
    }
}
