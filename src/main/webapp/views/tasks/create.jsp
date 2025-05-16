<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Create Task - Novatech</title>
    <!-- Tailwind CSS via CDN -->
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        body {
            background-color: #f9fafb;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        .form-input:focus, .form-textarea:focus, .form-select:focus {
            box-shadow: 0 0 0 3px rgba(79, 70, 229, 0.2);
            border-color: #6366f1;
        }
    </style>
</head>
<body>
    <!-- Navigation Bar -->
    <nav class="bg-white shadow-sm">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
            <div class="flex justify-between h-16">
                <div class="flex items-center">
                    <a href="tasks" class="text-2xl font-bold text-indigo-600">Novatech</a>
                </div>
                <div class="flex items-center">
                    <a href="logout" class="inline-flex items-center px-4 py-2 border border-transparent text-sm font-medium rounded-md shadow-sm text-white bg-indigo-600 hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500">
                        Logout
                    </a>
                    
                </div>
            </div>
        </div>
    </nav>

    <!-- Main Content -->
    <main class="max-w-3xl mx-auto py-6 px-4 sm:px-6 lg:px-8">
        <!-- Header -->
        <div class="mb-8">
            <div class="flex items-center">
                <a href="tasks" class="mr-2 text-indigo-600 hover:text-indigo-800">
                    <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" viewBox="0 0 20 20" fill="currentColor">
                        <path fill-rule="evenodd" d="M12.707 5.293a1 1 0 010 1.414L9.414 10l3.293 3.293a1 1 0 01-1.414 1.414l-4-4a1 1 0 010-1.414l4-4a1 1 0 011.414 0z" clip-rule="evenodd" />
                    </svg>
                </a>
                <h1 class="text-2xl font-semibold text-gray-900">Create New Task</h1>
            </div>
            <p class="mt-2 text-sm text-gray-600">Add a new task to your list and stay organized.</p>
        </div>

        <!-- Error Message (if any) -->
        <% String error = (String) request.getAttribute("error"); %>
        <% if (error != null) { %>
            <div class="mb-6 bg-red-50 border-l-4 border-red-400 p-4">
                <div class="flex">
                    <div class="flex-shrink-0">
                        <svg class="h-5 w-5 text-red-400" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor" aria-hidden="true">
                            <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zM8.707 7.293a1 1 0 00-1.414 1.414L8.586 10l-1.293 1.293a1 1 0 101.414 1.414L10 11.414l1.293 1.293a1 1 0 001.414-1.414L11.414 10l1.293-1.293a1 1 0 00-1.414-1.414L10 8.586 8.707 7.293z" clip-rule="evenodd" />
                        </svg>
                    </div>
                    <div class="ml-3">
                        <p class="text-sm text-red-700"><%= error %></p>
                    </div>
                </div>
            </div>
        <% } %>

        <!-- Task Form -->
        <div class="bg-white shadow overflow-hidden sm:rounded-lg">
            <form method="post" action="create-task" class="p-6">
                <div class="space-y-6">
                    <!-- Title Field -->
                    <div>
                        <label for="title" class="block text-sm font-medium text-gray-700">Task Title</label>
                        <div class="mt-1">
                            <input type="text" name="title" id="title" required 
                                class="form-input p-2 block w-full rounded-md border-gray-300 shadow-sm focus:ring-0 sm:text-sm" 
                                placeholder="Enter a clear title for your task">
                        </div>
                    </div>

                    <!-- Description Field -->
                    <div>
                        <label for="description" class="block text-sm font-medium text-gray-700">Description</label>
                        <div class="mt-1">
                            <textarea name="description" id="description" rows="4" 
                                class="form-textarea block p-2 w-full rounded-md border-gray-300 shadow-sm focus:ring-0 sm:text-sm" 
                                placeholder="Provide details about what needs to be done"></textarea>
                        </div>
                        <p class="mt-2 text-sm text-gray-500">Write a detailed description of the task for clarity.</p>
                    </div>

                    <!-- Due Date Field -->
                    <div>
                        <label for="dueDate" class="block text-sm font-medium text-gray-700">Due Date</label>
                        <div class="mt-1">
                            <input type="date" name="dueDate" id="dueDate" 
                                class="form-input block w-full p-2 rounded-md border-gray-300 shadow-sm focus:ring-0 sm:text-sm">
                        </div>
                    </div>

                    <!-- Priority Field -->
                    <div>
                        <label for="priority" class="block text-sm font-medium text-gray-700">Priority</label>
                        <div class="mt-1">
                            <select name="priority" id="priority" 
                                class="form-select p-2 block w-full rounded-md border-gray-300 shadow-sm focus:ring-0 sm:text-sm">
                                <option value="LOW">Low</option>
                                <option value="MEDIUM" selected>Medium</option>
                                <option value="HIGH">High</option>
                            </select>
                        </div>
                    </div>

                    <!-- Status Field -->
                    <div>
                        <label for="status" class="block text-sm font-medium text-gray-700">Status</label>
                        <div class="mt-1">
                            <select name="status" id="status" 
                                class="form-select p-2 block w-full rounded-md border-gray-300 shadow-sm focus:ring-0 sm:text-sm">
                                <option value="PENDING" selected>Pending</option>
                                <option value="IN_PROGRESS">In Progress</option>
                                <option value="COMPLETED">Completed</option>
                            </select>
                        </div>
                    </div>
                </div>

                <!-- Form Buttons -->
                <div class="mt-8 flex justify-end space-x-3">
                    <a href="tasks" 
                        class="inline-flex justify-center py-2 px-4 border border-gray-300 shadow-sm text-sm font-medium rounded-md text-gray-700 bg-white hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500">
                        Cancel
                    </a>
                    <button type="submit" 
                        class="inline-flex justify-center py-2 px-4 border border-transparent shadow-sm text-sm font-medium rounded-md text-white bg-indigo-600 hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500">
                        Create Task
                    </button>
                </div>
            </form>
        </div>
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