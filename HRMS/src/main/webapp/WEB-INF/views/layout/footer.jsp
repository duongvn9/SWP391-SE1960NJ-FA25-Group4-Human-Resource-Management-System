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

                // Sidebar dropdown toggle
                document.querySelectorAll('.sidebar-dropdown-toggle').forEach(function(toggle) {
                    toggle.addEventListener('click', function(e) {
                        e.preventDefault();
                        const targetId = this.getAttribute('data-target');
                        const submenu = document.getElementById(targetId);
                        const arrow = this.querySelector('.dropdown-arrow');
                        
                        if (submenu) {
                            if (submenu.classList.contains('show')) {
                                submenu.classList.remove('show');
                                this.setAttribute('aria-expanded', 'false');
                                arrow.style.transform = 'rotate(0deg)';
                            } else {
                                // Close other submenus
                                document.querySelectorAll('.sidebar-submenu').forEach(function(menu) {
                                    menu.classList.remove('show');
                                });
                                document.querySelectorAll('.sidebar-dropdown-toggle').forEach(function(otherToggle) {
                                    otherToggle.setAttribute('aria-expanded', 'false');
                                    const otherArrow = otherToggle.querySelector('.dropdown-arrow');
                                    if (otherArrow) otherArrow.style.transform = 'rotate(0deg)';
                                });
                                
                                // Open current submenu
                                submenu.classList.add('show');
                                this.setAttribute('aria-expanded', 'true');
                                arrow.style.transform = 'rotate(90deg)';
                            }
                        }
                    });
                });

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