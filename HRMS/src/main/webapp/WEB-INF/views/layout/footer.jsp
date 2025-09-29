<%@ page contentType="text/html; charset=UTF-8" %>
    <%@ taglib uri="jakarta.tags.core" prefix="c" %>
        <!-- Bootstrap JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

        <script>
            // Sidebar toggle functionality
            document.addEventListener('DOMContentLoaded', function () {
                const toggleBtn = document.getElementById('toggle-sidebar');
                const sidebar = document.getElementById('sidebar');
                const mainContent = document.getElementById('main-content');

                if (toggleBtn && sidebar && mainContent) {
                    toggleBtn.addEventListener('click', function () {
                        sidebar.classList.toggle('collapsed');
                        mainContent.classList.toggle('expanded');
                    });
                }

                // Mobile sidebar toggle
                if (window.innerWidth <= 768) {
                    if (toggleBtn && sidebar) {
                        toggleBtn.addEventListener('click', function () {
                            sidebar.classList.toggle('show');
                        });
                    }
                }
            });
        </script>