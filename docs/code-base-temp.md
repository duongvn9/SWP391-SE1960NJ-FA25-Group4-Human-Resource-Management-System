hrms/
└─ src/
   └─ main/
      ├─ java/
      │  └─ group4/hrms/
      │     ├─ common/
      │     │  ├─ config/           # AppConfig, DataSourceProvider (nếu không dùng JNDI)
      │     │  ├─ db/               # JdbcTemplate, RowMapper, BaseRepository
      │     │  ├─ web/              # BaseServlet, AppContextListener, Filters
      │     │  ├─ security/         # PasswordHasher, SessionAccount, RbacUtils
      │     │  └─ util/             # DateTimeUtil, JsonUtil, Paging
      │     ├─ identity/            # accounts, users, roles, features
      │     │  ├─ controller/
      │     │  ├─ service/
      │     │  ├─ repository/
      │     │  ├─ entity/
      │     │  ├─ dto/
      │     │  └─ mapper/
      │     ├─ requesttask/         # requests, tasks
      │     ├─ attendance/          # attendance_logs, timesheet_periods
      │     ├─ leave/               # leave_types, leave_balances, leave_ledger
      │     ├─ recruitment/         # applications, job_postings, interviews
      │     ├─ contract/            # templates, employment_contracts
      │     ├─ payroll/             # payroll_items
      │     └─ system/              # holidays, reports, system_params, feedback
      │
      ├─ resources/
      │  ├─ application.properties  # nếu tự tạo HikariCP thay vì JNDI
      │  ├─ logback.xml
      │  └─ META-INF/
      │     └─ persistence.xml      # chỉ cần nếu bạn dùng JPA; JDBC thuần thì bỏ
      │
      └─ webapp/
         ├─ index.jsp               # optional; forward vào /auth/login
         ├─ assets/                 # css, js, images
         ├─ META-INF/
         │  └─ context.xml          # JNDI DataSource: jdbc/HRMSDS (Tomcat)
         └─ WEB-INF/
            ├─ web.xml              # khai servlet/filter, welcome-file
            ├─ beans.xml            # (nếu dùng CDI; không thì bỏ)
            └─ views/
               ├─ layout/           # header.jspf, footer.jspf
               ├─ auth/             # login.jsp
               ├─ identity/
               ├─ requesttask/
               ├─ attendance/
               ├─ leave/
               ├─ recruitment/
               ├─ contract/
               ├─ payroll/
               └─ system/
