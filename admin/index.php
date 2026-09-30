<div class="admin-layout">

    <!-- SIDEBAR -->
    <aside class="admin-sidebar">

        <div class="admin-logo">
            <div class="admin-logo-icon">J</div>

            <div class="admin-logo-text">
                J<span>ainam</span>
            </div>
        </div>

        <div class="sidebar-title">Dashboard</div>

        <ul class="sidebar-menu">

            <li>
                <a href="index.php" class="active">
                    <span class="sidebar-icon">⌂</span>
                    Dashboard
                </a>
            </li>

            <li>
                <a href="cars.php">
                    <span class="sidebar-icon">🚗</span>
                    Cars & Fleet
                </a>
            </li>

            <li>
                <a href="bookings.php">
                    <span class="sidebar-icon">📅</span>
                    Bookings
                </a>
            </li>

            <li>
                <a href="feedback.php">
                    <span class="sidebar-icon">⭐</span>
                    Feedback
                </a>
            </li>

        </ul>

        <div class="sidebar-title">Account</div>

        <ul class="sidebar-menu">

            <li>
                <a href="../index.php">
                    <span class="sidebar-icon">🌐</span>
                    View Website
                </a>
            </li>

            <li>
                <a href="../logout.php">
                    <span class="sidebar-icon">↪</span>
                    Logout
                </a>
            </li>

        </ul>

    </aside>


    <!-- MAIN -->
    <main class="admin-main">

        <header class="admin-header">
        <link rel="stylesheet" href="../assets/admin.css">

            <div style="display:flex;align-items:center;gap:15px;">

                <button class="mobile-menu"
                        onclick="document.querySelector('.admin-sidebar').classList.toggle('open')">
                    ☰
                </button>

                <div>
                    <div class="admin-page-title">
                        Dashboard
                    </div>

                    <div class="admin-page-subtitle">
                        Welcome to Jainam Car Rental Admin Panel
                    </div>
                </div>

            </div>

            <div class="admin-profile">

                <div class="admin-avatar">
                    A
                </div>

                <span>
                    Admin
                </span>

            </div>

        </header>


        <div class="admin-content">

            <!-- STATISTICS -->

            <div class="dashboard-grid">

                <div class="stat-card">

                    <div class="stat-top">
                        <div class="stat-icon">🚗</div>
                    </div>

                    <div class="stat-number">
                        58
                    </div>

                    <div class="stat-label">
                        Total Vehicles
                    </div>

                </div>


                <div class="stat-card">

                    <div class="stat-top">
                        <div class="stat-icon">📅</div>
                    </div>

                    <div class="stat-number">
                        24
                    </div>

                    <div class="stat-label">
                        Total Bookings
                    </div>

                </div>


                <div class="stat-card">

                    <div class="stat-top">
                        <div class="stat-icon">👥</div>
                    </div>

                    <div class="stat-number">
                        120
                    </div>

                    <div class="stat-label">
                        Customers
                    </div>

                </div>


                <div class="stat-card">

                    <div class="stat-top">
                        <div class="stat-icon">₹</div>
                    </div>

                    <div class="stat-number">
                        ₹85,400
                    </div>

                    <div class="stat-label">
                        Booking Revenue
                    </div>

                </div>

            </div>


            <!-- RECENT BOOKINGS -->

            <div class="dashboard-section">

                <div class="section-header">

                    <div class="section-title">
                        Recent Bookings
                    </div>

                    <a href="bookings.php"
                       class="section-action">
                        View All →
                    </a>

                </div>


                <div class="admin-table-wrapper">

                    <table class="admin-table">

                        <thead>

                            <tr>
                                <th>Customer</th>
                                <th>Vehicle</th>
                                <th>Date</th>
                                <th>Amount</th>
                                <th>Status</th>
                                <th>Action</th>
                            </tr>

                        </thead>

                        <tbody>

                            <tr>

                                <td>
                                    Jainam Patel
                                </td>

                                <td>
                                    Toyota Innova HyCross
                                </td>

                                <td>
                                    16 Sep 2026
                                </td>

                                <td>
                                    ₹5,500
                                </td>

                                <td>
                                    <span class="badge badge-success">
                                        Confirmed
                                    </span>
                                </td>

                                <td>

                                    <a href="bookings.php"
                                       class="btn btn-sm btn-primary">
                                        View
                                    </a>

                                </td>

                            </tr>

                        </tbody>

                    </table>

                </div>

            </div>

        </div>

    </main>

</div>