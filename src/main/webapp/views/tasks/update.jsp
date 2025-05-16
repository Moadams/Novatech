<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.novatech.model.Task" %>
<%
    Task task = (Task) request.getAttribute("task");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Update Task - Novatech</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-50 font-sans">
    <main class="max-w-3xl mx-auto py-6 px-4 sm:px-6 lg:px-8">
        <div class="mb-8">
            <div class="flex items-center">
                <a href="tasks" class="mr-2 text-indigo-600 hover:text-indigo-800">
                    <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" fill="currentColor" viewBox="0 0 20 20">
                        <path fill-rule="evenodd" d="M12.707 5.293a1 1 0 010 1.414L9.414 10l3.293 3.293a1 1 0 01-1.414 1.414l-4-4a1 1 0 010-1.414l4-4a1 1 0 011.414 0z" clip-rule="evenodd"/>
                    </svg>
                </a>
                <h1 class="text-2xl font-semibold text-gray-900">Edit Task</h1>
            </div>
            <p class="mt-2 text-sm text-gray-600">Make changes to your task details.</p>
        </div>

        <!-- Error -->
        <% String error = (String) request.getAttribute("error"); %>
        <% if (error != null) { %>
            <div class="mb-6 bg-red-50 border-l-4 border-red-400 p-4">
                <p class="text-sm text-red-700"><%= error %></p>
            </div>
        <% } %>

        <!-- Form -->
        <div class="bg-white shadow sm:rounded-lg">
            <form method="post" action="update-task" class="p-6">
                <input type="hidden" name="id" value="<%= task.getTaskId() %>">

                <div class="space-y-6">
                    <!-- Title -->
                    <div>
                        <label for="title" class="block text-sm font-medium text-gray-700">Task Title</label>
                        <input type="text" name="title" id="title" required
                            value="<%= task.getTitle() %>"
                            class="form-input p-2 block w-full rounded-md border-gray-300 shadow-sm sm:text-sm">
                    </div>

                    <!-- Description -->
                    <div>
                        <label for="description" class="block text-sm font-medium text-gray-700">Description</label>
                        <textarea name="description" id="description" rows="4"
                            class="form-textarea p-2 block w-full rounded-md border-gray-300 shadow-sm sm:text-sm"><%= task.getDescription() %></textarea>
                    </div>

                    <!-- Due Date -->
                    <div>
                        <label for="dueDate" class="block text-sm font-medium text-gray-700">Due Date</label>
                        <input type="date" name="dueDate" id="dueDate"
                            value="<%= task.getDueDate() != null ? task.getDueDate().toString() : "" %>"
                            class="form-input p-2 block w-full rounded-md border-gray-300 shadow-sm sm:text-sm">
                    </div>

                    <!-- Priority -->
                    <div>
                        <label for="priority" class="block text-sm font-medium text-gray-700">Priority</label>
                        <select name="priority" id="priority"
                            class="form-select p-2 block w-full rounded-md border-gray-300 shadow-sm sm:text-sm">
                            <option value="LOW" <%= "LOW".equals(task.getPriority()) ? "selected" : "" %>>Low</option>
                            <option value="MEDIUM" <%= "MEDIUM".equals(task.getPriority()) ? "selected" : "" %>>Medium</option>
                            <option value="HIGH" <%= "HIGH".equals(task.getPriority()) ? "selected" : "" %>>High</option>
                        </select>
                    </div>

                    <!-- Status -->
                    <div>
                        <label for="status" class="block text-sm font-medium text-gray-700">Status</label>
                        <select name="status" id="status"
                            class="form-select p-2 block w-full rounded-md border-gray-300 shadow-sm sm:text-sm">
                            <option value="PENDING" <%= "PENDING".equals(task.getStatus()) ? "selected" : "" %>>Pending</option>
                            <option value="IN_PROGRESS" <%= "IN_PROGRESS".equals(task.getStatus()) ? "selected" : "" %>>In Progress</option>
                            <option value="COMPLETED" <%= "COMPLETED".equals(task.getStatus()) ? "selected" : "" %>>Completed</option>
                        </select>
                    </div>
                </div>

                <!-- Buttons -->
                <div class="mt-8 flex justify-end space-x-3">
                    <a href="tasks"
                       class="inline-flex justify-center py-2 px-4 border border-gray-300 text-sm font-medium rounded-md text-gray-700 bg-white hover:bg-gray-50">
                        Cancel
                    </a>
                    <button type="submit"
                        class="inline-flex justify-center py-2 px-4 border border-transparent text-sm font-medium rounded-md text-white bg-indigo-600 hover:bg-indigo-700">
                        Update Task
                    </button>
                </div>
            </form>
        </div>
    </main>
</body>
</html>
