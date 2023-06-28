<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>File Comparison Result</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 20px;
        }

        h2 {
            color: #333;
        }

        .container {
            max-width: 600px;
            margin: 0 auto;
            background-color: #f7f7f7;
            border: 1px solid #ccc;
            border-radius: 5px;
            padding: 20px;
        }

        .success-message {
            color: #008000;
            font-weight: bold;
        }

        .error-message {
            color: #f00;
            font-weight: bold;
        }

        .differences {
            white-space: pre-wrap;
        }

        .back-link {
            margin-top: 20px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>File Comparison Result</h2>

        <% if (request.getAttribute("error") != null) { %>
            <p class="error-message"><strong>Error:</strong> <%= request.getAttribute("error") %></p>
        <% } else { %>
            <% boolean areEqual = (boolean) request.getAttribute("areEqual");
            if (areEqual) { %>
                <p class="success-message">The files are identical.</p>
            <% } else { %>
                <p class="error-message">The files are different.</p>
                <h3>Differences:</h3>
                <% String differences = (String) request.getAttribute("differences");
                if (differences != null && !differences.trim().isEmpty()) { %>
                    <pre class="differences"><%= differences %></pre>
                <% } else { %>
                    <p>No differences found.</p>
                <% } %>
            <% } %>
        <% } %>

        <p class="back-link"><a href="/">Upload more files</a></p>
    </div>
</body>
</html>
