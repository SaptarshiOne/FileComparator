<!DOCTYPE html>
<html>
<head>
    <title>File Upload</title>
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
            max-width: 500px;
            margin: 0 auto;
            background-color: #f7f7f7;
            border: 1px solid #ccc;
            border-radius: 5px;
            padding: 20px;
        }

        .form-group {
            margin-bottom: 15px;
        }

        .form-group label {
            display: block;
            font-weight: bold;
            margin-bottom: 5px;
        }

        .form-group input[type="file"] {
            display: block;
            padding: 5px;
            border: 1px solid #ccc;
            border-radius: 3px;
            width: 100%;
        }

        .submit-btn {
            display: block;
            padding: 10px 20px;
            background-color: #4CAF50;
            color: #fff;
            text-align: center;
            text-decoration: none;
            border-radius: 3px;
            transition: background-color 0.3s;
            font-weight: bold;
        }

        .submit-btn:hover {
            background-color: #45a049;
        }

        .error-message {
            color: #f00;
            margin-top: 10px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Upload Files</h2>
        <form action="/compare" method="post" enctype="multipart/form-data">
            <div class="form-group">
                <label for="file1">File 1:</label>
                <input type="file" name="file1" id="file1" required>
            </div>
            <div class="form-group">
                <label for="file2">File 2:</label>
                <input type="file" name="file2" id="file2" required>
            </div>
            <input class="submit-btn" type="submit" value="Compare">
        </form>
    </div>
</body>
</html>
