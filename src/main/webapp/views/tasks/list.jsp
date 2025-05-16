<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="com.novatech.model.Task" %>
<%!
    // Method to format date as "time ago"
    public String getTimeAgo(Date date) {
        if (date == null) return "";
        
        long timeDiff = (new Date().getTime() - date.getTime()) / 1000; // difference in seconds
        
        if (timeDiff < 60) {
            return timeDiff + " sec" + (timeDiff == 1 ? "" : "s") + " ago";
        } else if (timeDiff < 3600) {
            long mins = timeDiff / 60;
            return mins + " min" + (mins == 1 ? "" : "s") + " ago";
        } else if (timeDiff < 86400) {
            long hours = timeDiff / 3600;
            return hours + " hour" + (hours == 1 ? "" : "s") + " ago";
        } else if (timeDiff < 604800) {
            long days = timeDiff / 86400;
            return days + " day" + (days == 1 ? "" : "s") + " ago";
        } else if (timeDiff < 2592000) {
            long weeks = timeDiff / 604800;
            return weeks + " week" + (weeks == 1 ? "" : "s") + " ago";
        } else if (timeDiff < 31536000) {
            long months = timeDiff / 2592000;
            return months + " month" + (months == 1 ? "" : "s") + " ago";
        } else {
            long years = timeDiff / 31536000;
            return years + " year" + (years == 1 ? "" : "s") + " ago";
        }
    }
    
    // Method to format due date
    public String formatDueDate(Date dueDate) {
        if (dueDate == null) return "No due date";
        
        SimpleDateFormat sdf = new SimpleDateFormat("MMM dd, yyyy");
        return sdf.format(dueDate);
    }
    
    // Method to get days remaining until due date
    public String getDaysRemaining(Date dueDate) {
        if (dueDate == null) return "";
        
        long diffInMillies = dueDate.getTime() - new Date().getTime();
        long diffInDays = diffInMillies / (24 * 60 * 60 * 1000);
        
        if (diffInDays < 0) {
            return Math.abs(diffInDays) + " day" + (Math.abs(diffInDays) == 1 ? "" : "s") + " overdue";
        } else if (diffInDays == 0) {
            return "Due today";
        } else {
            return diffInDays + " day" + (diffInDays == 1 ? "" : "s") + " left";
        }
    }
%>
<%
    List<Task> tasks = (List<Task>) request.getAttribute("tasks");
    boolean hasTasks = (tasks != null && !tasks.isEmpty());
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Your Tasks - Novatech</title>
    <!-- Tailwind CSS via CDN -->
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        body {
            background-color: #f9fafb;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        .task-card {
            transition: transform 0.2s, box-shadow 0.2s;
        }
        .task-card:hover {
            transform: translateY(-3px);
            box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.1), 0 4px 6px -2px rgba(0, 0, 0, 0.05);
        }
        .status-badge {
            display: inline-block;
            padding: 0.25rem 0.75rem;
            border-radius: 9999px;
            font-size: 0.75rem;
            font-weight: 500;
        }
        .status-pending { background-color: #FEF3C7; color: #92400E; }
        .status-in-progress { background-color: #DBEAFE; color: #1E40AF; }
        .status-completed { background-color: #D1FAE5; color: #065F46; }
        .priority-low { background-color: #E0F2FE; color: #0369A1; }
        .priority-medium { background-color: #FEF9C3; color: #854D0E; }
        .priority-high { background-color: #FEE2E2; color: #B91C1C; }
        .priority-critical { background-color: #FFCDD2; color: #7F1D1D; }
        .hidden {
            display: none;
        }
        .due-date-overdue {
            color: #DC2626;
        }
        .due-date-today {
            color: #D97706;
        }
        .due-date-upcoming {
            color: #2563EB;
        }
    </style>
</head>
<body>
    <!-- Navigation Bar -->
    <nav class="bg-white shadow-sm">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
            <div class="flex justify-between h-16">
                <div class="flex items-center">
                    <span class="text-2xl font-bold text-indigo-600">Novatech</span>
                </div>
                <div class="flex items-center">
                    <a href="create-task.jsp" class="inline-flex items-center px-4 py-2 border border-transparent text-sm font-medium rounded-md shadow-sm text-white bg-indigo-600 hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500">
                        Logout
                    </a>
                    
                </div>
            </div>
        </div>
    </nav>

    <!-- Main Content -->
    <main class="max-w-7xl mx-auto py-6 px-4 sm:px-6 lg:px-8">
        <!-- Header -->
        <div class="flex justify-between items-center mb-8">
            <h1 class="text-2xl font-semibold text-gray-900">My Tasks</h1>
            <a href="create-task" class="inline-flex items-center px-4 py-2 border border-transparent text-sm font-medium rounded-md shadow-sm text-white bg-indigo-600 hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500">
                <svg xmlns="http://www.w3.org/2000/svg" class="-ml-1 mr-2 h-5 w-5" viewBox="0 0 20 20" fill="currentColor">
                    <path fill-rule="evenodd" d="M10 5a1 1 0 011 1v3h3a1 1 0 110 2h-3v3a1 1 0 11-2 0v-3H6a1 1 0 110-2h3V6a1 1 0 011-1z" clip-rule="evenodd" />
                </svg>
                New Task
            </a>
        </div>

        <!-- Initial Empty State (only shown when there are truly no tasks) -->
        <% if (!hasTasks) { %>
        <div id="empty-state" class="bg-white rounded-lg shadow p-6 text-center">
            <img src="/api/placeholder/200/150" alt="No tasks" class="mx-auto mb-4">
            <h2 class="text-xl font-medium text-gray-900 mb-2">No tasks yet</h2>
            <p class="text-gray-500 mb-6">Create your first task to start being productive</p>
            <a href="create-task" class="inline-flex items-center px-4 py-2 border border-transparent text-sm font-medium rounded-md shadow-sm text-white bg-indigo-600 hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500">
                <svg xmlns="http://www.w3.org/2000/svg" class="-ml-1 mr-2 h-5 w-5" viewBox="0 0 20 20" fill="currentColor">
                    <path fill-rule="evenodd" d="M10 5a1 1 0 011 1v3h3a1 1 0 110 2h-3v3a1 1 0 11-2 0v-3H6a1 1 0 110-2h3V6a1 1 0 011-1z" clip-rule="evenodd" />
                </svg>
                Create Task
            </a>
        </div>
        <% } else { %>
        
        <!-- Task Filters -->
        <div class="bg-white rounded-lg shadow mb-6">
            <div class="px-4 py-5 sm:p-6">
                <div class="flex flex-wrap gap-4">
                    <div id="status-filters" class="flex flex-wrap gap-2">
                        <button class="filter-btn active inline-flex items-center px-3 py-1.5 border border-transparent text-xs font-medium rounded-full bg-indigo-100 text-indigo-800" data-filter="status" data-value="ALL">
                            All Tasks
                        </button>
                        <button class="filter-btn inline-flex items-center px-3 py-1.5 border border-gray-300 text-xs font-medium rounded-full text-gray-700 bg-white hover:bg-gray-50" data-filter="status" data-value="IN_PROGRESS">
                            In Progress
                        </button>
                        <button class="filter-btn inline-flex items-center px-3 py-1.5 border border-gray-300 text-xs font-medium rounded-full text-gray-700 bg-white hover:bg-gray-50" data-filter="status" data-value="COMPLETED">
                            Completed
                        </button>
                        <button class="filter-btn inline-flex items-center px-3 py-1.5 border border-gray-300 text-xs font-medium rounded-full text-gray-700 bg-white hover:bg-gray-50" data-filter="status" data-value="PENDING">
                            Pending
                        </button>
                    </div>

                    <div class="border-l border-gray-200 h-8 mx-2"></div>

                    <div id="priority-filters" class="flex flex-wrap gap-2">
                        <button class="filter-btn inline-flex items-center px-3 py-1.5 border border-gray-300 text-xs font-medium rounded-full text-gray-700 bg-white hover:bg-gray-50" data-filter="priority" data-value="HIGH">
                            High Priority
                        </button>
                        <button class="filter-btn inline-flex items-center px-3 py-1.5 border border-gray-300 text-xs font-medium rounded-full text-gray-700 bg-white hover:bg-gray-50" data-filter="priority" data-value="MEDIUM">
                            Medium Priority
                        </button>
                        <button class="filter-btn inline-flex items-center px-3 py-1.5 border border-gray-300 text-xs font-medium rounded-full text-gray-700 bg-white hover:bg-gray-50" data-filter="priority" data-value="LOW">
                            Low Priority
                        </button>
                    </div>
                </div>
            </div>
        </div>

        <!-- Filtered Empty State (shown when filter has no results) -->
        <div id="filtered-empty-state" class="hidden bg-white rounded-lg shadow p-6 text-center">
            <img src="/api/placeholder/200/150" alt="No matching tasks" class="mx-auto mb-4">
            <h2 class="text-xl font-medium text-gray-900 mb-2">No matching tasks</h2>
            <p class="text-gray-500 mb-6">There are no tasks matching the current filter</p>
            <a href="create-task" class="inline-flex items-center px-4 py-2 border border-transparent text-sm font-medium rounded-md shadow-sm text-white bg-indigo-600 hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500">
                <svg xmlns="http://www.w3.org/2000/svg" class="-ml-1 mr-2 h-5 w-5" viewBox="0 0 20 20" fill="currentColor">
                    <path fill-rule="evenodd" d="M10 5a1 1 0 011 1v3h3a1 1 0 110 2h-3v3a1 1 0 11-2 0v-3H6a1 1 0 110-2h3V6a1 1 0 011-1z" clip-rule="evenodd" />
                </svg>
                Create Task
            </a>
        </div>
        
        <!-- Task Cards -->
        <div id="task-grid" class="grid grid-cols-1 gap-6 sm:grid-cols-2 lg:grid-cols-3">
            <% for (Task task : tasks) { %>
                <div class="task-card bg-white overflow-hidden shadow rounded-lg" 
                     data-status="<%= task.getStatus() %>"
                     data-priority="<%= task.getPriority() %>">
                    <div class="px-4 py-5 sm:p-6">
                        <div class="flex justify-between items-start">
                            <h3 class="text-lg font-medium text-gray-900 mb-2"><%= task.getTitle() %></h3>
                            <div class="flex space-x-2">
                                <a href="update-task?id=<%= task.getTaskId() %>" class="text-gray-400 hover:text-gray-500">
                                    <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" viewBox="0 0 20 20" fill="currentColor">
                                        <path d="M13.586 3.586a2 2 0 112.828 2.828l-.793.793-2.828-2.828.793-.793zM11.379 5.793L3 14.172V17h2.828l8.38-8.379-2.83-2.828z" />
                                    </svg>
                                </a>
                                <a href="delete-task?id=<%= task.getTaskId() %>" class="text-gray-400 hover:text-red-500" onclick="return confirm('Are you sure you want to delete this task?')">
                                    <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" viewBox="0 0 20 20" fill="currentColor">
                                        <path fill-rule="evenodd" d="M9 2a1 1 0 00-.894.553L7.382 4H4a1 1 0 000 2v10a2 2 0 002 2h8a2 2 0 002-2V6a1 1 0 100-2h-3.382l-.724-1.447A1 1 0 0011 2H9zM7 8a1 1 0 012 0v6a1 1 0 11-2 0V8zm5-1a1 1 0 00-1 1v6a1 1 0 102 0V8a1 1 0 00-1-1z" clip-rule="evenodd" />
                                    </svg>
                                </a>
                            </div>
                        </div>
                        
                        <p class="mt-1 text-sm text-gray-600 line-clamp-3"><%= task.getDescription() %></p>
                        
                        <div class="mt-4 flex flex-wrap gap-2">
                            <span class="status-badge <%= task.getStatus().equals("COMPLETED") ? "status-completed" : task.getStatus().equals("IN_PROGRESS") ? "status-in-progress" : "status-pending" %>">
                                <%= task.getStatus() %>
                            </span>
                            
                            <span class="status-badge <%= 
                                task.getPriority().equals("HIGH") ? "priority-high" : 
                                task.getPriority().equals("MEDIUM") ? "priority-medium" : 
                                task.getPriority().equals("CRITICAL") ? "priority-critical" : 
                                "priority-low" %>">
                                <%= task.getPriority() %> Priority
                            </span>
                        </div>
                        
                        <div class="mt-3 border-t border-gray-100 pt-3">
                            <div class="flex justify-between items-center">
                                <div>
                                    <% if (task.getDueDate() != null) { 
                                        long diffInMillies = task.getDueDate().getTime() - new Date().getTime();
                                        long diffInDays = diffInMillies / (24 * 60 * 60 * 1000);
                                        String dueDateClass = diffInDays < 0 ? "due-date-overdue" : 
                                                             diffInDays == 0 ? "due-date-today" : 
                                                             "due-date-upcoming";
                                    %>
                                        <div class="flex items-center">
                                            <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4 text-gray-400 mr-1" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z" />
                                            </svg>
                                            <span class="text-xs <%= dueDateClass %>">
                                                <%= formatDueDate(task.getDueDate()) %> 
                                                (<%= getDaysRemaining(task.getDueDate()) %>)
                                            </span>
                                        </div>
                                    <% } else { %>
                                        <div class="flex items-center">
                                            <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4 text-gray-400 mr-1" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z" />
                                            </svg>
                                            <span class="text-xs text-gray-500">No due date</span>
                                        </div>
                                    <% } %>
                                </div>
                                <span class="text-xs text-gray-500"><%= getTimeAgo(task.getCreatedAt()) %></span>
                            </div>
                        </div>
                    </div>
                </div>
            <% } %>
        </div>
        <% } %>
    </main>

    <!-- Footer -->
    <footer class="bg-white mt-12">
        <div class="max-w-7xl mx-auto py-6 px-4 overflow-hidden sm:px-6 lg:px-8">
            <p class="text-center text-sm text-gray-500">
                &copy; 2025 Novatech. All rights reserved.
            </p>
        </div>
    </footer>

    <!-- JavaScript for Filtering Tasks -->
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const filterButtons = document.querySelectorAll('.filter-btn');
            const taskCards = document.querySelectorAll('.task-card');
            const taskGrid = document.getElementById('task-grid');
            const filteredEmptyState = document.getElementById('filtered-empty-state');
            
            // Current active filters
            let activeFilters = {
                status: 'ALL',
                priority: null
            };
            
            // Function to apply filters
            function applyFilters() {
                let visibleCount = 0;
                
                taskCards.forEach(card => {
                    const cardStatus = card.dataset.status;
                    const cardPriority = card.dataset.priority;
                    
                    // Check if card matches all active filters
                    const matchesStatus = activeFilters.status === 'ALL' || cardStatus === activeFilters.status;
                    const matchesPriority = !activeFilters.priority || cardPriority === activeFilters.priority;
                    
                    if (matchesStatus && matchesPriority) {
                        card.classList.remove('hidden');
                        visibleCount++;
                    } else {
                        card.classList.add('hidden');
                    }
                });
                
                // Show/hide empty state based on filter results
                if (visibleCount === 0) {
                    taskGrid.classList.add('hidden');
                    filteredEmptyState.classList.remove('hidden');
                } else {
                    taskGrid.classList.remove('hidden');
                    filteredEmptyState.classList.add('hidden');
                }
            }
            
            // Update filter button styles
            function updateFilterButtonStyles() {
                filterButtons.forEach(btn => {
                    const filterType = btn.dataset.filter;
                    const filterValue = btn.dataset.value;
                    
                    if (activeFilters[filterType] === filterValue) {
                        btn.classList.add('bg-indigo-100', 'text-indigo-800');
                        btn.classList.remove('bg-white', 'text-gray-700', 'border-gray-300');
                    } else {
                        btn.classList.remove('bg-indigo-100', 'text-indigo-800');
                        btn.classList.add('bg-white', 'text-gray-700', 'border-gray-300');
                    }
                });
            }
            
            // Add click event listeners to filter buttons
            filterButtons.forEach(button => {
                button.addEventListener('click', function() {
                    const filterType = this.dataset.filter;
                    const filterValue = this.dataset.value;
                    
                    // Toggle priority filters (can be turned off)
                    if (filterType === 'priority' && activeFilters.priority === filterValue) {
                        activeFilters.priority = null;
                    } else {
                        activeFilters[filterType] = filterValue;
                    }
                    
                    updateFilterButtonStyles();
                    applyFilters();
                });
            });
            
            // Initialize with "All Tasks" filter
            updateFilterButtonStyles();
            applyFilters();
        });
    </script>
</body>
</html>