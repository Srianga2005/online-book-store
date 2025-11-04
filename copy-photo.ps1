$source = "C:\Users\SRING NAYAK\Pictures\WhatsApp Image 2025-10-26 at 12.40.34_fea3de5a.jpg"
$destination = "t:\Adnavce\onlinebookstore-master\WebContent\images\profile.jpg"
Copy-Item -Path $source -Destination $destination -Force
Write-Host "Photo copied successfully!"
