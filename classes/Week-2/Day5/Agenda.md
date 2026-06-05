<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Daily Training Dashboard</title>

<style>
    body {
        font-family: Arial, sans-serif;
        background-color: #f4f6f9;
        margin: 20px;
        color: #333;
    }

    .container {
        max-width: 1200px;
        margin: auto;
    }

    .header {
        text-align: center;
        background: #2c3e50;
        color: white;
        padding: 20px;
        border-radius: 10px;
        margin-bottom: 20px;
    }

    .section {
        background: white;
        padding: 20px;
        margin-bottom: 20px;
        border-radius: 10px;
        box-shadow: 0px 2px 5px rgba(0,0,0,0.1);
    }

    .section h2 {
        color: #2c3e50;
        border-bottom: 2px solid #3498db;
        padding-bottom: 10px;
    }

    ul {
        padding-left: 20px;
    }

    table {
        width: 100%;
        border-collapse: collapse;
        margin-top: 10px;
    }

    table, th, td {
        border: 1px solid #ddd;
    }

    th {
        background-color: #3498db;
        color: white;
    }

    th, td {
        padding: 10px;
        text-align: left;
    }

    .card-container {
        display: flex;
        gap: 20px;
        flex-wrap: wrap;
    }

    .card {
        flex: 1;
        min-width: 250px;
        background: #ecf0f1;
        padding: 15px;
        border-radius: 8px;
    }

    .progress-bar {
        width: 100%;
        background-color: #ddd;
        border-radius: 20px;
        overflow: hidden;
        margin-top: 5px;
    }

    .progress {
        height: 20px;
        background-color: #27ae60;
        width: 0%;
        text-align: center;
        color: white;
        font-size: 12px;
        line-height: 20px;
    }

    .quote {
        text-align: center;
        font-style: italic;
        font-size: 18px;
        color: #555;
    }

    .emoji {
        font-size: 24px;
    }
</style>
</head>

<body>

<div class="container">

    <div class="header">
        <h1>📚 Daily Training Dashboard</h1>
        <p>Learning • Practice • Growth</p>
    </div>

    <!-- Revision -->
    <div class="section">
        <h2>🔄 Revision</h2>

        <div class="card-container">
            <div class="card">
                <h3>Topics to Revise</h3>
                <ul>
                    <li>SQL Joins</li>
                    <li>Subqueries</li>
                    <li>CTEs</li>
                    <li>Window Functions</li>
                </ul>
            </div>

            <div class="card">
                <h3>Key Takeaways</h3>
                <table>
                    <tr>
                        <th>Topic</th>
                        <th>Summary</th>
                    </tr>
                    <tr>
                        <td>Joins</td>
                        <td>Combine data from multiple tables</td>
                    </tr>
                    <tr>
                        <td>CTE</td>
                        <td>Reusable temporary result set</td>
                    </tr>
                    <tr>
                        <td>Window Functions</td>
                        <td>Perform calculations across rows</td>
                    </tr>
                </table>
            </div>
        </div>
    </div>

    <!-- Today's Topic -->
    <div class="section">
        <h2>🎯 Today's Topic</h2>

        <h3>Advanced SQL - Common Table Expressions (CTE)</h3>

        <ul>
            <li>Understand CTE Syntax</li>
            <li>Learn Recursive CTE</li>
            <li>Compare CTE vs Subqueries</li>
            <li>Solve Real-world Problems</li>
        </ul>

        <pre>
WITH dept_salary AS (
    SELECT dept_id,
           AVG(salary) AS avg_salary
    FROM employees
    GROUP BY dept_id
)
SELECT * FROM dept_salary;
        </pre>
    </div>

    <!-- Problems -->
    <div class="section">
        <h2>🧩 Problems</h2>

        <h3>Beginner</h3>
        <ul>
            <li>Find highest salary in each department.</li>
            <li>Find employees earning above department average.</li>
        </ul>

        <h3>Intermediate</h3>
        <ul>
            <li>Top 3 customers by sales.</li>
            <li>Find duplicate records using CTE.</li>
        </ul>

        <h3>Advanced</h3>
        <ul>
            <li>Employee-Manager Hierarchy using Recursive CTE.</li>
            <li>Running Total using Window Functions.</li>
        </ul>

        <h3>🏆 Challenge</h3>
        <p>Build a query that returns the top-selling product for each month.</p>
    </div>

    <!-- Quiz -->
    <div class="section">
        <h2>❓ Quiz</h2>

        <ol>
            <li>
                What does CTE stand for?
                <ul>
                    <li>Common Table Engine</li>
                    <li><b>Common Table Expression</b></li>
                    <li>Common Table Entry</li>
                    <li>Common Type Expression</li>
                </ul>
            </li>

            <li>
                Which keyword defines a CTE?
                <ul>
                    <li>TEMP</li>
                    <li>VIEW</li>
                    <li><b>WITH</b></li>
                    <li>CREATE</li>
                </ul>
            </li>

            <li>
                Which CTE type is used for hierarchical data?
                <ul>
                    <li>Simple CTE</li>
                    <li><b>Recursive CTE</b></li>
                    <li>Nested CTE</li>
                    <li>Materialized CTE</li>
                </ul>
            </li>
        </ol>
    </div>

    <!-- Events -->
    <div class="section">
        <h2>🏆 Events & Announcements</h2>

        <table>
            <tr>
                <th>Date</th>
                <th>Event</th>
            </tr>
            <tr>
                <td>10-Aug-2026</td>
                <td>SQL Assessment</td>
            </tr>
            <tr>
                <td>15-Aug-2026</td>
                <td>Mock Interview</td>
            </tr>
            <tr>
                <td>20-Aug-2026</td>
                <td>Hackathon</td>
            </tr>
        </table>
    </div>

    <!-- Progress Tracker -->
    <div class="section">
        <h2>📊 Progress Tracker</h2>

        <p>Revision Completed</p>
        <div class="progress-bar">
            <div class="progress" style="width:75%">75%</div>
        </div>

        <p>Topic Coverage</p>
        <div class="progress-bar">
            <div class="progress" style="width:60%">60%</div>
        </div>

        <p>Problems Solved</p>
        <div class="progress-bar">
            <div class="progress" style="width:40%">40%</div>
        </div>

        <p>Quiz Completion</p>
        <div class="progress-bar">
            <div class="progress" style="width:90%">90%</div>
        </div>
    </div>

    <!-- Quote -->
    <div class="section">
        <h2>💡 Quote of the Day</h2>

        <div class="quote">
            "Practice isn't the thing you do once you're good.
            It's the thing you do that makes you good."
        </div>
    </div>

</div>

</body>
</html>
