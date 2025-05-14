<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.novatech.model.Task" %>
<%
    List<Task> tasks = (List<Task>) request.getAttribute("tasks");
    boolean hasTasks = tasks != null && !tasks.isEmpty();
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
            <a href="create-task.jsp" class="inline-flex items-center px-4 py-2 border border-transparent text-sm font-medium rounded-md shadow-sm text-white bg-indigo-600 hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500">
                <svg xmlns="http://www.w3.org/2000/svg" class="-ml-1 mr-2 h-5 w-5" viewBox="0 0 20 20" fill="currentColor">
                    <path fill-rule="evenodd" d="M10 5a1 1 0 011 1v3h3a1 1 0 110 2h-3v3a1 1 0 11-2 0v-3H6a1 1 0 110-2h3V6a1 1 0 011-1z" clip-rule="evenodd" />
                </svg>
                New Task
            </a>
        </div>

        <!-- Empty State -->
        <% if (!hasTasks) { %>
        <div class="bg-white rounded-lg shadow p-6 text-center">
            <img src="/api/placeholder/200/150" alt="No tasks" class="mx-auto mb-4">
            <h2 class="text-xl font-medium text-gray-900 mb-2">No tasks yet</h2>
            <p class="text-gray-500 mb-6">Create your first task to start being productive</p>
            <a href="create-task.jsp" class="inline-flex items-center px-4 py-2 border border-transparent text-sm font-medium rounded-md shadow-sm text-white bg-indigo-600 hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500">
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
                    <button class="inline-flex items-center px-3 py-1.5 border border-transparent text-xs font-medium rounded-full bg-indigo-100 text-indigo-800">
                        All Tasks
                    </button>
                    <button class="inline-flex items-center px-3 py-1.5 border border-gray-300 text-xs font-medium rounded-full text-gray-700 bg-white hover:bg-gray-50">
                        In Progress
                    </button>
                    <button class="inline-flex items-center px-3 py-1.5 border border-gray-300 text-xs font-medium rounded-full text-gray-700 bg-white hover:bg-gray-50">
                        Completed
                    </button>
                    <button class="inline-flex items-center px-3 py-1.5 border border-gray-300 text-xs font-medium rounded-full text-gray-700 bg-white hover:bg-gray-50">
                        Pending
                    </button>
                </div>
            </div>
        </div>
        
        <!-- Task Cards -->
        <div class="grid grid-cols-1 gap-6 sm:grid-cols-2 lg:grid-cols-3">
            <c:forEach var="task" items="${tasks}">
                <div class="task-card bg-white overflow-hidden shadow rounded-lg">
                    <div class="px-4 py-5 sm:p-6">
                        <div class="flex justify-between items-start">
                            <h3 class="text-lg font-medium text-gray-900 mb-2">${task.title}</h3>
                            <div class="flex space-x-2">
                                <a href="edit-task.jsp?id=${task.id}" class="text-gray-400 hover:text-gray-500">
                                    <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" viewBox="0 0 20 20" fill="currentColor">
                                        <path d="M13.586 3.586a2 2 0 112.828 2.828l-.793.793-2.828-2.828.793-.793zM11.379 5.793L3 14.172V17h2.828l8.38-8.379-2.83-2.828z" />
                                    </svg>
                                </a>
                                <a href="delete-task?id=${task.id}" class="text-gray-400 hover:text-red-500" onclick="return confirm('Are you sure you want to delete this task?')">
                                    <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" viewBox="0 0 20 20" fill="currentColor">
                                        <path fill-rule="evenodd" d="M9 2a1 1 0 00-.894.553L7.382 4H4a1 1 0 000 2v10a2 2 0 002 2h8a2 2 0 002-2V6a1 1 0 100-2h-3.382l-.724-1.447A1 1 0 0011 2H9zM7 8a1 1 0 012 0v6a1 1 0 11-2 0V8zm5-1a1 1 0 00-1 1v6a1 1 0 102 0V8a1 1 0 00-1-1z" clip-rule="evenodd" />
                                    </svg>
                                </a>
                            </div>
                        </div>
                        <p class="mt-1 text-sm text-gray-600 line-clamp-3">${task.description}</p>
                        <div class="mt-4 flex justify-between items-center">
                            <span class="status-badge ${task.status == 'COMPLETED' ? 'status-completed' : task.status == 'IN_PROGRESS' ? 'status-in-progress' : 'status-pending'}">
                                ${task.status}
                            </span>
                            <span class="text-xs text-gray-500">Created 2 days ago</span>
                        </div>
                    </div>
                </div>
            </c:forEach>
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
</body>
</html>