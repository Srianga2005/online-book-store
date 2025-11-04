// Admin Dashboard JavaScript

// Mobile menu toggle
document.addEventListener('DOMContentLoaded', function() {
    const menuToggle = document.querySelector('.menu-toggle');
    const sidebar = document.querySelector('.sidebar');
    
    if (menuToggle) {
        menuToggle.addEventListener('click', function() {
            sidebar.classList.toggle('active');
        });
    }
    
    // Close sidebar when clicking outside on mobile
    document.addEventListener('click', function(e) {
        if (window.innerWidth <= 1024) {
            if (!sidebar.contains(e.target) && !menuToggle.contains(e.target)) {
                sidebar.classList.remove('active');
            }
        }
    });
    
    // Navigation
    const navItems = document.querySelectorAll('.nav-item[data-page]');
    navItems.forEach(item => {
        item.addEventListener('click', function(e) {
            e.preventDefault();
            
            // Remove active class from all items
            navItems.forEach(nav => nav.classList.remove('active'));
            
            // Add active class to clicked item
            this.classList.add('active');
            
            // Get page name
            const page = this.getAttribute('data-page');
            
            // Here you can add logic to load different content
            console.log('Navigating to:', page);
            
            // Close sidebar on mobile
            if (window.innerWidth <= 1024) {
                sidebar.classList.remove('active');
            }
        });
    });
    
    // Close promo banner
    const promoClose = document.querySelector('.promo-banner .btn-close');
    if (promoClose) {
        promoClose.addEventListener('click', function() {
            document.querySelector('.promo-banner').style.display = 'none';
        });
    }
    
    // Initialize Charts
    initializeCharts();
});

// Chart initialization
function initializeCharts() {
    // Mini Charts Configuration
    const miniChartConfig = {
        type: 'line',
        options: {
            responsive: true,
            maintainAspectRatio: false,
            plugins: {
                legend: {
                    display: false
                },
                tooltip: {
                    enabled: false
                }
            },
            scales: {
                x: {
                    display: false
                },
                y: {
                    display: false
                }
            },
            elements: {
                line: {
                    borderWidth: 2,
                    tension: 0.4
                },
                point: {
                    radius: 0
                }
            }
        }
    };
    
    // Earnings Chart
    const earningsCtx = document.getElementById('earningsChart');
    if (earningsCtx) {
        new Chart(earningsCtx, {
            ...miniChartConfig,
            data: {
                labels: ['1', '2', '3', '4', '5', '6', '7'],
                datasets: [{
                    data: [30, 40, 35, 50, 45, 60, 55],
                    borderColor: '#5f63f2',
                    backgroundColor: 'rgba(95, 99, 242, 0.1)',
                    fill: true
                }]
            }
        });
    }
    
    // Product Chart
    const productCtx = document.getElementById('productChart');
    if (productCtx) {
        new Chart(productCtx, {
            ...miniChartConfig,
            data: {
                labels: ['1', '2', '3', '4', '5', '6', '7'],
                datasets: [{
                    data: [20, 35, 30, 45, 40, 55, 50],
                    borderColor: '#5f63f2',
                    backgroundColor: 'rgba(95, 99, 242, 0.1)',
                    fill: true
                }]
            }
        });
    }
    
    // Orders Chart
    const ordersCtx = document.getElementById('ordersChart');
    if (ordersCtx) {
        new Chart(ordersCtx, {
            ...miniChartConfig,
            data: {
                labels: ['1', '2', '3', '4', '5', '6', '7'],
                datasets: [{
                    data: [25, 30, 35, 40, 38, 45, 48],
                    borderColor: '#5f63f2',
                    backgroundColor: 'rgba(95, 99, 242, 0.1)',
                    fill: true
                }]
            }
        });
    }
    
    // Main Chart
    const mainCtx = document.getElementById('mainChart');
    if (mainCtx) {
        new Chart(mainCtx, {
            type: 'line',
            data: {
                labels: ['2000', '2500', '3000', '3500', '4000', '4500', '5000', '5500'],
                datasets: [
                    {
                        label: 'Sales',
                        data: [2800, 3200, 2900, 3500, 3100, 3800, 3400, 3900],
                        borderColor: '#fa8b0c',
                        backgroundColor: 'rgba(250, 139, 12, 0.1)',
                        fill: true,
                        tension: 0.4,
                        borderWidth: 2
                    },
                    {
                        label: 'Revenue',
                        data: [2200, 2600, 2400, 2900, 2700, 3200, 2900, 3300],
                        borderColor: '#5f63f2',
                        backgroundColor: 'rgba(95, 99, 242, 0.1)',
                        fill: true,
                        tension: 0.4,
                        borderWidth: 2
                    }
                ]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: {
                        display: false
                    },
                    tooltip: {
                        mode: 'index',
                        intersect: false,
                        backgroundColor: 'rgba(0, 0, 0, 0.8)',
                        padding: 12,
                        cornerRadius: 8,
                        titleFont: {
                            size: 13
                        },
                        bodyFont: {
                            size: 13
                        }
                    }
                },
                scales: {
                    x: {
                        grid: {
                            display: false
                        },
                        ticks: {
                            font: {
                                size: 12
                            },
                            color: '#8c8c8c'
                        }
                    },
                    y: {
                        grid: {
                            color: '#f0f0f0',
                            drawBorder: false
                        },
                        ticks: {
                            font: {
                                size: 12
                            },
                            color: '#8c8c8c'
                        }
                    }
                },
                interaction: {
                    mode: 'nearest',
                    axis: 'x',
                    intersect: false
                }
            }
        });
    }
}

// Utility function to format currency
function formatCurrency(amount) {
    return new Intl.NumberFormat('en-US', {
        style: 'currency',
        currency: 'USD'
    }).format(amount);
}

// Utility function to format numbers
function formatNumber(num) {
    return new Intl.NumberFormat('en-US').format(num);
}

// Search functionality
const searchInput = document.querySelector('.search-box input');
if (searchInput) {
    searchInput.addEventListener('input', function(e) {
        const searchTerm = e.target.value.toLowerCase();
        console.log('Searching for:', searchTerm);
        // Add your search logic here
    });
}

// Notification handling
function showNotification(message, type = 'info') {
    // Create notification element
    const notification = document.createElement('div');
    notification.className = `notification notification-${type}`;
    notification.textContent = message;
    notification.style.cssText = `
        position: fixed;
        top: 20px;
        right: 20px;
        padding: 15px 20px;
        background: white;
        border-radius: 8px;
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
        z-index: 9999;
        animation: slideIn 0.3s ease;
    `;
    
    document.body.appendChild(notification);
    
    // Remove after 3 seconds
    setTimeout(() => {
        notification.style.animation = 'slideOut 0.3s ease';
        setTimeout(() => notification.remove(), 300);
    }, 3000);
}

// Add animation styles
const style = document.createElement('style');
style.textContent = `
    @keyframes slideIn {
        from {
            transform: translateX(100%);
            opacity: 0;
        }
        to {
            transform: translateX(0);
            opacity: 1;
        }
    }
    
    @keyframes slideOut {
        from {
            transform: translateX(0);
            opacity: 1;
        }
        to {
            transform: translateX(100%);
            opacity: 0;
        }
    }
`;
document.head.appendChild(style);

// Export functions for use in other scripts
window.dashboardUtils = {
    formatCurrency,
    formatNumber,
    showNotification
};
