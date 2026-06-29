$ErrorActionPreference = "Stop"

Write-Host "Checking API Gateway health..."
$ready = $false
for ($i = 0; $i -lt 90; $i++) {
    try {
        Invoke-RestMethod -Uri "http://localhost:5000/health" | Out-Null
        $ready = $true
        break
    } catch {
        Start-Sleep -Seconds 2
    }
}

if (-not $ready) {
    throw "Gateway health check did not become ready in time."
}

$email = "aarav.demo.$([Guid]::NewGuid().ToString('N').Substring(0,8))@example.com"
$student = Invoke-RestMethod -Method Post -Uri "http://localhost:5000/api/students" -ContentType "application/json" -Body (@{ fullName = "Aarav Sharma"; email = $email } | ConvertTo-Json)
$course = Invoke-RestMethod -Method Post -Uri "http://localhost:5000/api/courses" -ContentType "application/json" -Body (@{ title = "Scalable Systems"; credits = 4 } | ConvertTo-Json)
$enrollment = Invoke-RestMethod -Method Post -Uri "http://localhost:5000/api/enrollments" -ContentType "application/json" -Body (@{ studentId = $student.id; courseId = $course.id } | ConvertTo-Json)

Start-Sleep -Seconds 2
$enrollments = Invoke-RestMethod -Uri "http://localhost:5000/api/enrollments"
$events = Invoke-RestMethod -Uri "http://localhost:5000/api/courses/enrollment-events"

$result = [PSCustomObject]@{
    studentId = $student.id
    courseId = $course.id
    enrollmentId = $enrollment.id
    enrollmentsCount = $enrollments.Count
    consumedEventsCount = $events.Count
}

Write-Host "Demo smoke test completed:"
$result | ConvertTo-Json -Depth 4
