#yes, this code is probably an experienced powershell users nightmare, but i have 0 knowledge of powershell and just needed to put together something quickly for some friends to use
#made by katznboyz/katznboyz1 (2020)

Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$form = New-Object System.Windows.Forms.Form
$form.Text = "katznboyz's simple youtube downloader"
$form.Size = New-Object System.Drawing.Size(400,280)
$form.StartPosition = 'CenterScreen'

$okButton = New-Object System.Windows.Forms.Button
$okButton.Location = New-Object System.Drawing.Point(100,200)
$okButton.Size = New-Object System.Drawing.Size(100,23)
$okButton.Text = 'START'
$okButton.DialogResult = [System.Windows.Forms.DialogResult]::OK
$form.AcceptButton = $okButton
$form.Controls.Add($okButton)

$cancelButton = New-Object System.Windows.Forms.Button
$cancelButton.Location = New-Object System.Drawing.Point(200,200)
$cancelButton.Size = New-Object System.Drawing.Size(100,23)
$cancelButton.Text = 'Cancel'
$cancelButton.DialogResult = [System.Windows.Forms.DialogResult]::Cancel
$form.CancelButton = $cancelButton
$form.Controls.Add($cancelButton)

$label1 = New-Object System.Windows.Forms.Label
$label1.Location = New-Object System.Drawing.Point(10,20)
$label1.Size = New-Object System.Drawing.Size(380,20)
$label1.Text = 'Youtube link (required):'
$form.Controls.Add($label1)

$linkTextBox = New-Object System.Windows.Forms.TextBox
$linkTextBox.Location = New-Object System.Drawing.Point(10,40)
$linkTextBox.Size = New-Object System.Drawing.Size(360,20)
$form.Controls.Add($linkTextBox)

$label2 = New-Object System.Windows.Forms.Label
$label2.Location = New-Object System.Drawing.Point(10,80)
$label2.Size = New-Object System.Drawing.Size(380,20)
$label2.Text = 'Download format (required):'
$form.Controls.Add($label2)

$formatListBox = new-object System.Windows.Forms.ComboBox
$formatListBox.Location = new-object System.Drawing.Point(10,100)
$formatListBox.Size = new-object System.Drawing.Size(360,20)

$formatListBox.Items.Add('mp4')
$formatListBox.Items.Add('m4a')
$formatListBox.Items.Add('webm')

$formatListBox.SelectedItem = $formatListBox.Items[0]

$form.Controls.Add($formatListBox)

$label3 = New-Object System.Windows.Forms.Label
$label3.Location = New-Object System.Drawing.Point(10,140)
$label3.Size = New-Object System.Drawing.Size(380,20)
$label3.Text = 'Download path (required):'
$form.Controls.Add($label3)

$pathTextBox = New-Object System.Windows.Forms.TextBox
$pathTextBox.Location = New-Object System.Drawing.Point(10,160)
$pathTextBox.Size = New-Object System.Drawing.Size(360,20)
$pathTextBox.Text = Get-Location
$form.Controls.Add($pathTextBox)

$form.Topmost = $true

$form.Add_Shown({$linkTextBox.Select()})
$result = $form.ShowDialog()

if ($result -eq [System.Windows.Forms.DialogResult]::OK)
{
    echo "Downloading videos. You will be alerted when this program is done."
    
    $currentDir = Get-Location
    $currentDir = $currentDir.tostring()
    $URL = $linkTextBox.Text
    $format = $formatListBox.SelectedItem
    $dir = $pathTextBox.Text
    
    ./youtube-dl.exe -U
    cd $dir
    Invoke-Expression ($currentDir + "\\youtube-dl.exe -f " + $format + " " + $URL)

    $exitStatusFormTitle = '???'
    $exitStatusFormContent = '???'
    
    if ($LASTEXITCODE -eq 0) {
        $exitStatusFormTitle = 'Success!'
        $exitStatusFormContent = 'All of the videos were downloaded!'
    } else {
        $exitStatusFormTitle = 'Error.'
        $exitStatusFormContent = 'Check the output to see what went wrong.'
    }

    $form = New-Object System.Windows.Forms.Form
    $form.Text = $exitStatusFormTitle
    $form.Size = New-Object System.Drawing.Size(400,280)
    $form.StartPosition = 'CenterScreen'

    $okButton = New-Object System.Windows.Forms.Button
    $okButton.Location = New-Object System.Drawing.Point(100,200)
    $okButton.Size = New-Object System.Drawing.Size(100,23)
    $okButton.Text = 'OK'
    $okButton.DialogResult = [System.Windows.Forms.DialogResult]::OK
    $form.AcceptButton = $okButton
    $form.Controls.Add($okButton)

    $cancelButton = New-Object System.Windows.Forms.Button
    $cancelButton.Location = New-Object System.Drawing.Point(200,200)
    $cancelButton.Size = New-Object System.Drawing.Size(100,23)
    $cancelButton.Text = 'Cancel'
    $cancelButton.DialogResult = [System.Windows.Forms.DialogResult]::Cancel
    $form.CancelButton = $cancelButton
    $form.Controls.Add($cancelButton)

    $label1 = New-Object System.Windows.Forms.Label
    $label1.Location = New-Object System.Drawing.Point(10,20)
    $label1.Size = New-Object System.Drawing.Size(380,20)
    $label1.Text = $exitStatusFormContent
    $form.Controls.Add($label1)

    $form.Topmost = $true

    $form.Add_Shown({$linkTextBox.Select()})
    $result = $form.ShowDialog()

}