package group4.hrms.controller.employee;

import group4.hrms.dto.request.CreateAccountRequestDTO;
import group4.hrms.dto.request.UpdateAccountRequestDTO;
import group4.hrms.dto.response.AccountResponseDTO;
import group4.hrms.entity.Department;
import group4.hrms.entity.Role;
import group4.hrms.entity.User;
import group4.hrms.service.employee.AccountManagementService;
import group4.hrms.constants.AppConstants;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;
import java.util.Optional;

/**
 * Controller xử lý Account Management cho admin
 */
@WebServlet({
    "/admin/accounts",
    "/admin/accounts/create", 
    "/admin/accounts/edit",
    "/admin/accounts/delete",
    "/admin/accounts/toggle-status"
})
public class AccountManagementController extends HttpServlet {
    private AccountManagementService accountManagementService;

    @Override
    public void init() throws ServletException {
        super.init();
        this.accountManagementService = new AccountManagementService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String path = request.getServletPath();
        
        try {
            switch (path) {
                case "/admin/accounts":
                    showAccountList(request, response);
                    break;
                case "/admin/accounts/create":
                    showCreateAccountForm(request, response);
                    break;
                case "/admin/accounts/edit":
                    showEditAccountForm(request, response);
                    break;
                default:
                    response.sendError(HttpServletResponse.SC_NOT_FOUND);
            }
        } catch (Exception e) {
            request.setAttribute(AppConstants.REQUEST_ERROR_MESSAGE, 
                "Đã xảy ra lỗi: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/views/error.jsp")
                .forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String path = request.getServletPath();
        
        try {
            switch (path) {
                case "/admin/accounts/create":
                    handleCreateAccount(request, response);
                    break;
                case "/admin/accounts/edit":
                    handleUpdateAccount(request, response);
                    break;
                case "/admin/accounts/delete":
                    handleDeleteAccount(request, response);
                    break;
                case "/admin/accounts/toggle-status":
                    handleToggleAccountStatus(request, response);
                    break;
                default:
                    response.sendError(HttpServletResponse.SC_NOT_FOUND);
            }
        } catch (Exception e) {
            request.setAttribute(AppConstants.REQUEST_ERROR_MESSAGE, 
                "Đã xảy ra lỗi: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/views/error.jsp")
                .forward(request, response);
        }
    }

    /**
     * Hiển thị danh sách accounts
     */
    private void showAccountList(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        List<AccountResponseDTO> accounts = accountManagementService.getAllAccounts();
        request.setAttribute("accounts", accounts);
        
        request.getRequestDispatcher("/WEB-INF/views/admin/accounts/list.jsp")
            .forward(request, response);
    }

    /**
     * Hiển thị form tạo account mới
     */
    private void showCreateAccountForm(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Lấy danh sách roles
        List<Role> roles = accountManagementService.getAllRoles();
        request.setAttribute("roles", roles);
        
        // Lấy danh sách departments
        List<Department> departments = accountManagementService.getAllDepartments();
        request.setAttribute("departments", departments);
        
        request.getRequestDispatcher("/WEB-INF/views/admin/accounts/create.jsp")
            .forward(request, response);
    }

    /**
     * Hiển thị form chỉnh sửa account
     */
    private void showEditAccountForm(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String accountIdParam = request.getParameter("id");
        
        if (accountIdParam == null || accountIdParam.trim().isEmpty()) {
            request.setAttribute(AppConstants.REQUEST_ERROR_MESSAGE, 
                "ID account không hợp lệ");
            response.sendRedirect(request.getContextPath() + "/admin/accounts");
            return;
        }
        
        try {
            Long accountId = Long.parseLong(accountIdParam);
            Optional<AccountResponseDTO> accountOpt = accountManagementService.getAccountById(accountId);
            
            if (accountOpt.isEmpty()) {
                request.setAttribute(AppConstants.REQUEST_ERROR_MESSAGE, 
                    "Không tìm thấy account");
                response.sendRedirect(request.getContextPath() + "/admin/accounts");
                return;
            }
            
            request.setAttribute("account", accountOpt.get());
            
            // Lấy danh sách roles
            List<Role> roles = accountManagementService.getAllRoles();
            request.setAttribute("roles", roles);
            
            request.getRequestDispatcher("/WEB-INF/views/admin/accounts/edit.jsp")
                .forward(request, response);
                
        } catch (NumberFormatException e) {
            request.setAttribute(AppConstants.REQUEST_ERROR_MESSAGE, 
                "ID account không hợp lệ");
            response.sendRedirect(request.getContextPath() + "/admin/accounts");
        }
    }

    /**
     * Xử lý tạo account mới  
     */
    private void handleCreateAccount(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try {
            // Lấy thông tin từ form
            CreateAccountRequestDTO requestDTO = buildCreateAccountRequest(request);
            
            // Tạo account
            Long accountId = accountManagementService.createAccount(requestDTO);
            
            HttpSession session = request.getSession();
            session.setAttribute(AppConstants.REQUEST_SUCCESS_MESSAGE, 
                "Tạo account thành công với ID: " + accountId);
            
            response.sendRedirect(request.getContextPath() + "/admin/accounts");
            
        } catch (IllegalArgumentException e) {
            // Lỗi validation
            request.setAttribute(AppConstants.REQUEST_ERROR_MESSAGE, e.getMessage());
            showCreateAccountForm(request, response);
        } catch (Exception e) {
            request.setAttribute(AppConstants.REQUEST_ERROR_MESSAGE, 
                "Lỗi khi tạo account: " + e.getMessage());
            showCreateAccountForm(request, response);
        }
    }

    /**
     * Xử lý cập nhật account
     */
    private void handleUpdateAccount(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try {
            // Lấy thông tin từ form
            UpdateAccountRequestDTO requestDTO = buildUpdateAccountRequest(request);
            
            // Cập nhật account
            boolean updated = accountManagementService.updateAccount(requestDTO);
            
            HttpSession session = request.getSession();
            if (updated) {
                session.setAttribute(AppConstants.REQUEST_SUCCESS_MESSAGE, 
                    "Cập nhật account thành công");
            } else {
                session.setAttribute(AppConstants.REQUEST_ERROR_MESSAGE, 
                    "Không thể cập nhật account");
            }
            
            response.sendRedirect(request.getContextPath() + "/admin/accounts");
            
        } catch (IllegalArgumentException e) {
            // Lỗi validation
            request.setAttribute(AppConstants.REQUEST_ERROR_MESSAGE, e.getMessage());
            showEditAccountForm(request, response);
        } catch (Exception e) {
            request.setAttribute(AppConstants.REQUEST_ERROR_MESSAGE, 
                "Lỗi khi cập nhật account: " + e.getMessage());
            showEditAccountForm(request, response);
        }
    }

    /**
     * Xử lý xóa account
     */
    private void handleDeleteAccount(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String accountIdParam = request.getParameter("id");
        
        try {
            Long accountId = Long.parseLong(accountIdParam);
            
            boolean deleted = accountManagementService.deleteAccount(accountId);
            
            HttpSession session = request.getSession();
            if (deleted) {
                session.setAttribute(AppConstants.REQUEST_SUCCESS_MESSAGE, 
                    "Xóa account thành công");
            } else {
                session.setAttribute(AppConstants.REQUEST_ERROR_MESSAGE, 
                    "Không thể xóa account");
            }
            
        } catch (NumberFormatException e) {
            HttpSession session = request.getSession();
            session.setAttribute(AppConstants.REQUEST_ERROR_MESSAGE, 
                "ID account không hợp lệ");
        } catch (Exception e) {
            HttpSession session = request.getSession();
            session.setAttribute(AppConstants.REQUEST_ERROR_MESSAGE, 
                "Lỗi khi xóa account: " + e.getMessage());
        }
        
        response.sendRedirect(request.getContextPath() + "/admin/accounts");
    }

    /**
     * Xử lý bật/tắt trạng thái account
     */
    private void handleToggleAccountStatus(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String accountIdParam = request.getParameter("id");
        
        try {
            Long accountId = Long.parseLong(accountIdParam);
            
            boolean toggled = accountManagementService.toggleAccountStatus(accountId);
            
            HttpSession session = request.getSession();
            if (toggled) {
                session.setAttribute(AppConstants.REQUEST_SUCCESS_MESSAGE, 
                    "Thay đổi trạng thái account thành công");
            } else {
                session.setAttribute(AppConstants.REQUEST_ERROR_MESSAGE, 
                    "Không thể thay đổi trạng thái account");
            }
            
        } catch (NumberFormatException e) {
            HttpSession session = request.getSession();
            session.setAttribute(AppConstants.REQUEST_ERROR_MESSAGE, 
                "ID account không hợp lệ");
        } catch (Exception e) {
            HttpSession session = request.getSession();
            session.setAttribute(AppConstants.REQUEST_ERROR_MESSAGE, 
                "Lỗi khi thay đổi trạng thái account: " + e.getMessage());
        }
        
        response.sendRedirect(request.getContextPath() + "/admin/accounts");
    }

    /**
     * Build CreateAccountRequestDTO từ request parameters
     */
    private CreateAccountRequestDTO buildCreateAccountRequest(HttpServletRequest request) {
        CreateAccountRequestDTO dto = new CreateAccountRequestDTO();
        
        // User info
        dto.setFullName(request.getParameter("fullName"));
        dto.setEmail(request.getParameter("email"));
        dto.setPhone(request.getParameter("phone"));
        
        String deptIdParam = request.getParameter("departmentId");
        if (deptIdParam != null && !deptIdParam.trim().isEmpty()) {
            dto.setDepartmentId(Long.parseLong(deptIdParam));
        }
        
        // Username
        dto.setUsername(request.getParameter("username"));
        
        // Password
        dto.setPassword(request.getParameter("password"));
        dto.setConfirmPassword(request.getParameter("confirmPassword"));
        
        // Roles
        String[] roleIdStrings = request.getParameterValues("roleIds");
        if (roleIdStrings != null && roleIdStrings.length > 0) {
            Long[] roleIds = new Long[roleIdStrings.length];
            for (int i = 0; i < roleIdStrings.length; i++) {
                roleIds[i] = Long.parseLong(roleIdStrings[i]);
            }
            dto.setRoleIds(roleIds);
        }
        
        // Active status
        String activeParam = request.getParameter("isActive");
        dto.setActive(activeParam != null && "true".equals(activeParam));
        
        return dto;
    }

    /**
     * Build UpdateAccountRequestDTO từ request parameters
     */
    private UpdateAccountRequestDTO buildUpdateAccountRequest(HttpServletRequest request) {
        UpdateAccountRequestDTO dto = new UpdateAccountRequestDTO();
        
        // Account ID
        String accountIdParam = request.getParameter("accountId");
        if (accountIdParam != null && !accountIdParam.trim().isEmpty()) {
            dto.setAccountId(Long.parseLong(accountIdParam));
        }
        
        // Username
        dto.setUsername(request.getParameter("username"));
        
        // New Password (optional)
        dto.setNewPassword(request.getParameter("newPassword"));
        dto.setConfirmPassword(request.getParameter("confirmPassword"));
        
        // Roles
        String[] roleIdStrings = request.getParameterValues("roleIds");
        if (roleIdStrings != null && roleIdStrings.length > 0) {
            Long[] roleIds = new Long[roleIdStrings.length];
            for (int i = 0; i < roleIdStrings.length; i++) {
                roleIds[i] = Long.parseLong(roleIdStrings[i]);
            }
            dto.setRoleIds(roleIds);
        }
        
        // Active status
        String activeParam = request.getParameter("isActive");
        dto.setActive(activeParam != null && "true".equals(activeParam));
        
        return dto;
    }
}