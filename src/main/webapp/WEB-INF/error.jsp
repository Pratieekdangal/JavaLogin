<%@ page contentType="text/html;charset=UTF-8" language="java" isErrorPage="true" %>
    <!DOCTYPE html>
    <html>

    <head>
        <title>Error - JobConnect</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    </head>

    <body>
        <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
            <div class="container">
                <a class="navbar-brand" href="${pageContext.request.contextPath}/">JobConnect</a>
            </div>
        </nav>

        <div class="container mt-5">
            <div class="row justify-content-center">
                <div class="col-md-8">
                    <div class="card">
                        <div class="card-body text-center">
                            <h1 class="display-1 text-danger mb-4">Oops!</h1>
                            <h2 class="mb-4">Something went wrong</h2>

                            <p class="lead mb-4">
                                We're sorry, but we encountered an error while processing your request.
                                <br>
                                Please try again or contact support if the problem persists.
                            </p>

                            <% if (request.getAttribute("error") !=null) { %>
                                <div class="alert alert-danger">
                                    <%= request.getAttribute("error") %>
                                </div>
                                <% } %>

                                    <div class="mt-4">
                                        <a href="${pageContext.request.contextPath}/" class="btn btn-primary me-2">Go to
                                            Homepage</a>
                                        <button onclick="history.back()" class="btn btn-secondary">Go Back</button>
                                    </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>

    </html>