<#
    WARNING!
    ---------------------------------------------------------------------------
    This program is intended solely for demonstration and educational purposes. 
    Running this code can be risky and may harm your system. It is strongly    
    recommended to execute it in a virtual machine or a controlled environment.
    ---------------------------------------------------------------------------

    DISCLAIMER: The author and developer of this code assume no responsibility for
    any damage or issues that may arise from using this software. By running, 
    modifying, or sharing this code, you agree to do so at your own risk.
    
    ---------------------------------------------------------------------------

    NOTE: This code contains functions that can be used in your projects. 
    Modifying it for malicious purposes, including creating virus-like programs, 
    is illegal and unethical. 

    ---------------------------------------------------------------------------

    This program may cause unintended disruptions to system operations and can 
    risk data corruption. It is important to understand that this program is 
    for educational purposes and should be used responsibly and ethically. 

    If you choose to distribute this program, you must provide the open-source 
    code to all who download it.

    ---------------------------------------------------------------------------

    ADDITIONAL NOTE: Users must be fully aware of the potential dangers involved 
    when running this code in any environment.

    ===========================================================================

    By proceeding, you acknowledge that you have read and understood this 
    disclaimer and agree to use the code responsibly in a controlled 
    educational environment.
#>

# Load the necessary .NET assemblies
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# Show warnings
# WARNING: Removing or modifing these warnings to prevent users from understanding the actions of this program, it can lead to serious issues or conflicts.
function Show-Message {
    param (
        [string]$Title,
        [string]$Message
    )

    Add-Type -AssemblyName PresentationFramework

    [System.Windows.MessageBox]::Show($Message, $Title, [System.Windows.MessageBoxButton]::YesNo, [System.Windows.MessageBoxImage]::Warning)
}

# First warning
$warningConfirm1 = Show-Message -Title "Warning!" -Message @"
WARNING!

This program is intended solely for educational and demonstration purposes. The author assumes no responsibility for any consequences, including system damage or data loss.

It is strongly recommended to run this program only in a controlled environment, such as a virtual machine.

Click "No" to abort.
"@

if ($warningConfirm1 -eq [System.Windows.MessageBoxResult]::Yes) {
    # Second warning
    $warningConfirm2 = Show-Message -Title "Final Confirmation" -Message @"
FINAL WARNING!

You are about to run this program.

This program is intended solely for educational and demonstration purposes. The author assumes no responsibility for any consequences, including system damage or data loss.

It is strongly recommended to run this program only in a controlled environment, such as a virtual machine.

Click "No" to abort.

Proceed at your own risk.
"@

    if ($warningConfirm2 -eq [System.Windows.MessageBoxResult]::Yes) {
        # Continue executing
    } else {
        exit 1
    }
} else {
    exit 1
}

# Define the Gdi32 class 
Add-Type @"
    using System;
    using System.Runtime.InteropServices;

    public class Gdi32 {
        [DllImport("kernel32.dll", SetLastError = true)]
        [return: MarshalAs(UnmanagedType.Bool)]
        public static extern bool FreeLibrary(IntPtr hModule);

        [DllImport("user32.dll", SetLastError = true)]
        public static extern IntPtr GetDC(IntPtr hwnd);
		
		[DllImport("gdi32.dll", SetLastError = true)]
		public static extern bool DeleteDC(IntPtr hDC);

        [DllImport("user32.dll", SetLastError = true)]
        public static extern int ReleaseDC(IntPtr hDC);

        [DllImport("gdi32.dll", SetLastError = true)]
        public static extern uint SetPixel(IntPtr hDC, int X, int Y, uint color);

        [DllImport("gdi32.dll", SetLastError = true)]
        [return: MarshalAs(UnmanagedType.Bool)]
        public static extern bool Rectangle(IntPtr hDC, int left, int top, int right, int bottom);

        [DllImport("gdi32.dll", SetLastError = true)]
        [return: MarshalAs(UnmanagedType.Bool)]
        public static extern bool Ellipse(IntPtr hDC, int left, int top, int right, int bottom);

        [DllImport("gdi32.dll", SetLastError = true)]
        public static extern IntPtr CreatePen(int fnPenStyle, int nWidth, uint crColor);

        [DllImport("gdi32.dll", SetLastError = true)]
        public static extern IntPtr SelectObject(IntPtr hDC, IntPtr hObject);

        [DllImport("gdi32.dll", SetLastError = true)]
        [return: MarshalAs(UnmanagedType.Bool)]
        public static extern bool DeleteObject(IntPtr hObject);

        [DllImport("gdi32.dll", SetLastError = true)]
        public static extern int TextOut(IntPtr hDC, int x, int y, string lpString, int c);

        [DllImport("gdi32.dll", SetLastError = true)]
        public static extern uint SetTextColor(IntPtr hDC, uint color);

        [DllImport("gdi32.dll", SetLastError = true)]
        public static extern uint SetBkColor(IntPtr hDC, uint color);

        [DllImport("gdi32.dll", SetLastError = true)]
        public static extern uint SetBkMode(IntPtr hDC, int mode);

        [DllImport("gdi32.dll", SetLastError = true)]
        [return: MarshalAs(UnmanagedType.Bool)]
        public static extern bool BitBlt(IntPtr hdcDest, int nXDest, int nYDest, int nWidth, int nHeight, IntPtr hdcSrc, int nXSrc, int nySrc, uint dwRop);

        [DllImport("gdi32.dll", SetLastError = true)]
        public static extern IntPtr CreateCompatibleDC(IntPtr hDC);

        [DllImport("gdi32.dll", SetLastError = true)]
        public static extern IntPtr CreateFont(int nHeight, int nWidth, int nEscapement, int nOrientation, int fnWeight, uint fdwItalic, uint fdwUnderline, uint fdwStrikeOut, uint fdwCharSet, uint fdwOutputPrecision, uint fdwClipPrecision, uint fdwQuality, uint fdwPitchAndFamily, string lpszFace);

        [DllImport("gdi32.dll", SetLastError = true)]
        public static extern bool MoveToEx(IntPtr hDC, int X, int Y, IntPtr lpPoint);

        [DllImport("gdi32.dll", SetLastError = true)]
        public static extern bool LineTo(IntPtr hDC, int X, int Y);

        [DllImport("gdi32.dll", SetLastError = true)]
        public static extern IntPtr CreateSolidBrush(uint crColor);

        [DllImport("gdi32.dll", SetLastError = true)]
        public static extern bool PatBlt(IntPtr hDC, int x, int y, int cx, int cy, uint dwRop);
		
		[DllImport("gdi32.dll", SetLastError = true)]
		public static extern bool StretchBlt(IntPtr hdcDest, int nXOriginDest, int nYOriginDest, int nWidthDest, int nHeightDest,
                                         IntPtr hdcSrc, int nXOriginSrc, int nYOriginSrc, int nWidthSrc, int nHeightSrc, int dwRop);


        [DllImport("msimg32.dll", SetLastError = true)]
		[return: MarshalAs(UnmanagedType.Bool)]
		public static extern bool TransparentBlt(IntPtr hdcDest, int nXDest, int nYDest, int nWidthDest, int nHeightDest, IntPtr hdcSrc, int nXSrc, int nYSrc, int nWidthSrc, int nHeightSrc, uint crTransparent);
		
        [DllImport("gdi32.dll", SetLastError = true)]
        public static extern IntPtr CreateCompatibleBitmap(IntPtr hDC, int nWidth, int nHeight);
		
		public static uint RGB(byte red, byte green, byte blue) {
            return (uint)((red << 16) | (green << 8) | blue);
        }

        public const uint SRCCOPY = 0x00CC0020;
        public const uint SRCPAINT = 0x00EE0086;
        public const uint SRCAND = 0x008800C6;
        public const uint SRCINVERT = 0x00660046;
        public const uint SRCERASE = 0x00440328;
        public const uint NOTSRCCOPY = 0x00330008;
        public const uint NOTSRCERASE = 0x001100A6;
        public const uint MERGECOPY = 0x00C000CA;
        public const uint PATCOPY = 0x00F00021;
        public const uint PATPAINT = 0x00FB0A09;
        public const uint PATINVERT = 0x005A0049;
        public const uint DSTINVERT = 0x00550009;
        public const uint BLACKNESS = 0x00000042;
        public const uint WHITENESS = 0x00FF0062;

        public const int WHITE_BRUSH = 0;
        public const int LTGRAY_BRUSH = 1; 
        public const int GRAY_BRUSH = 2;
        public const int DKGRAY_BRUSH = 3;
        public const int BLACK_BRUSH = 4;
        public const int NULL_BRUSH = 5;
        public const int HOLLOW_BRUSH = NULL_BRUSH;
        public const int WHITE_PEN = 6;
        public const int BLACK_PEN = 7;
        public const int NULL_PEN = 8;
        public const int OEM_FIXED_FONT = 10;
        public const int ANSI_FIXED_FONT = 11;
        public const int ANSI_VAR_FONT = 12;
        public const int SYSTEM_FONT = 13;
        public const int DEVICE_DEFAULT_FONT = 14;
        public const int DEFAULT_PALETTE = 15;
        public const int SYSTEM_FIXED_FONT = 16;
        public const int DEFAULT_GUI_FONT = 17;
        public const int DC_BRUSH = 18;
        public const int DC_PEN = 19;
        
        public const int TRANSPARENT = 1;
        public const int OPAQUE = 2;
    }
"@

# Define the User32 class
Add-Type @"
using System;
using System.Runtime.InteropServices;

public class User32 {
    [DllImport("user32.dll", SetLastError = true)]
    public static extern bool ShowWindow(IntPtr hWnd, int nCmdShow);

    [DllImport("user32.dll", SetLastError = true)]
    public static extern IntPtr FindWindow(string lpClassName, string lpWindowName);

    [DllImport("user32.dll", SetLastError = true)]
    public static extern bool SetForegroundWindow(IntPtr hWnd);

    [DllImport("user32.dll", SetLastError = true)]
    public static extern bool PostMessage(IntPtr hWnd, uint Msg, IntPtr wParam, IntPtr lParam);
	
    [DllImport("user32.dll", SetLastError = true)]
    public static extern IntPtr GetWindowThreadProcessId(IntPtr hWnd, out uint lpdwProcessId);

    [DllImport("user32.dll", SetLastError = true)]
    public static extern bool GetWindowRect(IntPtr hWnd, out RECT lpRect);

    [DllImport("user32.dll", SetLastError = true)]
    public static extern bool GetClientRect(IntPtr hWnd, out RECT lpRect);

    [DllImport("user32.dll", SetLastError = true)]
    public static extern bool MoveWindow(IntPtr hWnd, int X, int Y, int nWidth, int nHeight, bool bRepaint);

    [DllImport("user32.dll", SetLastError = true)]
    public static extern bool GetWindowText(IntPtr hWnd, System.Text.StringBuilder lpString, int nMaxCount);

    [DllImport("user32.dll", SetLastError = true)]
    public static extern bool SetWindowText(IntPtr hWnd, string lpString);

    [DllImport("user32.dll", SetLastError = true)]
    public static extern bool GetWindowPlacement(IntPtr hWnd, out WINDOWPLACEMENT lpWindowPlacement);

    [DllImport("user32.dll", SetLastError = true)]
    public static extern bool SetWindowPlacement(IntPtr hWnd, ref WINDOWPLACEMENT lpWindowPlacement);

    [DllImport("user32.dll")]
    public static extern bool GetCursorPos(out POINT lpPoint);

    [DllImport("user32.dll")]
    public static extern bool SetCursorPos(int X, int Y);
	
	[DllImport("user32.dll", SetLastError = true)]
    public static extern bool InvalidateRect(IntPtr hWnd, IntPtr lpRect, bool bErase);
	
	[DllImport("user32.dll", CharSet = CharSet.Auto)]
    public static extern int SystemParametersInfo(int uAction, int uParam, string lpvParam, int fuWinIni);
	
    [DllImport("user32.dll", SetLastError = true)]
    public static extern bool EnumWindows(EnumWindowsProc lpEnumFunc, IntPtr lParam);
	
    public delegate bool EnumWindowsProc(IntPtr hWnd, IntPtr lParam);


    [StructLayout(LayoutKind.Sequential)]
    public struct RECT {
        public int left;
        public int top;
        public int right;
        public int bottom;
    }

    [StructLayout(LayoutKind.Sequential)]
    public struct WINDOWPLACEMENT {
        public int length;
        public int flags;
        public int showCmd;
        public POINT ptMinPosition;
        public POINT ptMaxPosition;
        public RECT rcNormalPosition;
    }

    [StructLayout(LayoutKind.Sequential)]
    public struct POINT {
        public int X;
        public int Y;
    }

    public const int SW_SHOW = 5;
    public const int SW_HIDE = 0;
    public const uint WM_CLOSE = 0x0010;
    public const uint WM_QUIT = 0x0012;
}
"@

<#
    Function: Invoke-BSOD
    -----------------------
    REMOVED!!!
#>

<#
	RESOURCES FUNCTIONS 
	------------------------
	Default resources manage functions.
#>

function Get-ResourcePath {
	param (
		[string]$Name
	)
	
	return Join-Path -Path $currentPath -ChildPath $Name
}

# Function to play audio file
function Play-Audio {
    param (
        [string]$Path
    )

    $soundPlayer = New-Object System.Media.SoundPlayer
    $soundPlayer.SoundLocation = $Path
    $soundPlayer.Load()
    $soundPlayer.Play()
	
	return $soundPlayer
}

<#
	BASIC METHODS
	---------------------
	Defined by defualt often methods, with user32, gdi32 classes.
#>

$currentScreen = [System.Windows.Forms.Screen]::PrimaryScreen.Bounds;
$width = $currentScreen.width;
$height = $currentScreen.height;

# Device Context Methods
function Get-DC {
    return [Gdi32]::GetDC([IntPtr]::Zero)
}

function Get-CompatibleDC {
	$oldhdctmp1 = [Gdi32]::CreateCompatibleDC($hDC)
	[void][Gdi32]::BitBlt($oldhdctmp1, 0, 0, $width, $height, $hDC, 0, 0, [Gdi32]::SRCCOPY)
	return $oldhdctmp1
}

function Release-DC {
    param (
        [IntPtr]$HDC
    )
    [void][Gdi32]::ReleaseDC($HDC)
}

function Screen-InvertAll {
	Screen-ROPOperation -ROP $ROP_DSTINVERT
}

function Screen-ROPOperation {
	param (
		[int]$ROP
	)
	
	$ropCode = Get-ROPFromIndex $ROP
	
	$oldhDC = [Gdi32]::CreateCompatibleDC($hdc)
    $hbm = [Gdi32]::CreateCompatibleBitmap($hDC, $width, $height)
    $hOldBmp = [Gdi32]::SelectObject($oldhdc, $hbm)

    [void][Gdi32]::BitBlt($oldhdc, 0, 0, $width, $height, $hDC, 0, 0, [Gdi32]::SRCCOPY)
    [void][Gdi32]::BitBlt($hDC, 0, 0, $width, $height, $oldhdc, 0, 0, $ropCode)

    [void][Gdi32]::SelectObject($oldhdc, $hOldBmp)
    [void][Gdi32]::DeleteObject($hbm)
    [void][Gdi32]::DeleteDC($oldhDC)
}

function Screen-Stretch {
    param (
        [int]$Power,
        [int]$ROP = 0,
        [int]$OffsetX = 0,
        [int]$OffsetY = 0,
        [switch]$Inside,
        [switch]$Outside
    )
	
    $srcWidth = $width
    $srcHeight = $height

    if ($Inside) {
        $destWidth = $width - $Power
        $destHeight = $height - $Power
        $xOffset = ($Power / 2) + $OffsetX
        $yOffset = ($Power / 2) + $OffsetY
    } elseif ($Outside) {
        $destWidth = $width + $Power
        $destHeight = $height + $Power
        $xOffset = (-$Power / 2) + $OffsetX
        $yOffset = (-$Power / 2) + $OffsetY
    }

    $ropCode = Get-ROPFromIndex $ROP

    $oldhDC = [Gdi32]::CreateCompatibleDC($hdc)
    $hbm = [Gdi32]::CreateCompatibleBitmap($hDC, $srcWidth, $srcHeight)
    $hOldBmp = [Gdi32]::SelectObject($oldhDC, $hbm)

    [void][Gdi32]::BitBlt($oldhDC, 0, 0, $srcWidth, $srcHeight, $hDC, 0, 0, [Gdi32]::SRCCOPY)
    [void][Gdi32]::StretchBlt($hDC, $xOffset, $yOffset, $destWidth, $destHeight, $oldhDC, 0, 0, $srcWidth, $srcHeight, $ropCode)

    [void][Gdi32]::SelectObject($oldhDC, $hOldBmp)
    [void][Gdi32]::DeleteObject($hbm)
    [void][Gdi32]::DeleteDC($oldhDC)
}

function Screen-Flip {
    param (
        [switch]$Horizontal,
        [switch]$Vertical
    )

    $oldhDC = [Gdi32]::CreateCompatibleDC($hdc)
    $hbm = [Gdi32]::CreateCompatibleBitmap($hDC, $width, $height)
    $hOldBmp = [Gdi32]::SelectObject($oldhdc, $hbm)

    [void][Gdi32]::BitBlt($oldhdc, 0, 0, $width, $height, $hDC, 0, 0, [Gdi32]::SRCCOPY)

    if ($Vertical -and $Horizontal) {
        [void][Gdi32]::StretchBlt($hDC, 0, 0, $width, $height, $oldhdc, $width, $height, -$width, -$height, [Gdi32]::SRCCOPY)
    } elseif ($Vertical) {
        [void][Gdi32]::StretchBlt($hDC, 0, 0, $width, $height, $oldhdc, 0, $height, $width, -$height, [Gdi32]::SRCCOPY)
    } elseif ($Horizontal) {
        [void][Gdi32]::StretchBlt($hDC, 0, 0, $width, $height, $oldhdc, $width, 0, -$width, $height, [Gdi32]::SRCCOPY)
    }

    [void][Gdi32]::SelectObject($oldhdc, $hOldBmp)
    [void][Gdi32]::DeleteObject($hbm)
    [void][Gdi32]::DeleteDC($oldhDC)
}

function Screen-Pixelate {
	param (
		[float]$Power
	)
	
    $oldhDC = [Gdi32]::CreateCompatibleDC($hDC)
    $hBitmap = [Gdi32]::CreateCompatibleBitmap($hDC, $width, $height)
    [void][Gdi32]::SelectObject($oldhDC, $hBitmap)

    [void][Gdi32]::BitBlt($oldhDC, 0, 0, $width, $height, $hDC, 0, 0, [Gdi32]::SRCCOPY)

    $oldhDCPixel = [Gdi32]::CreateCompatibleDC($hDC)
    $hBitmapPixel = [Gdi32]::CreateCompatibleBitmap($hDC, $width / $Power, $height / $Power)
    [void][Gdi32]::SelectObject($oldhDCPixel, $hBitmapPixel)

    [void][Gdi32]::StretchBlt($oldhDCPixel, 0, 0, $width / $Power, $height / $Power, $oldhDC, 0, 0, $width, $height, [Gdi32]::SRCCOPY)

    [void][Gdi32]::StretchBlt($hDC, 0, 0, $width, $height, $oldhDCPixel, 0, 0, $width / $Power, $height / $Power, [Gdi32]::SRCCOPY)

    [void][Gdi32]::DeleteDC($oldhDCPixel)
    [void][Gdi32]::DeleteObject($hBitmap)
    [void][Gdi32]::DeleteObject($hBitmapPixel)
    [void][Gdi32]::DeleteDC($oldhDC)
}

function Screen-Move {
	param (
		[int]$OffsetX,
		[int]$OffsetY
	)
	
	$oldhDC = [Gdi32]::CreateCompatibleDC($hdc)
    $hbm = [Gdi32]::CreateCompatibleBitmap($hDC, $width, $height)
    $hOldBmp = [Gdi32]::SelectObject($oldhdc, $hbm)

    [void][Gdi32]::BitBlt($oldhdc, 0, 0, $width, $height, $hDC, 0, 0, [Gdi32]::SRCCOPY)
    [void][Gdi32]::BitBlt($hDC, $OffsetX, $OffsetY, $width, $height, $oldhdc, 0, 0, [Gdi32]::SRCCOPY)
    [void][Gdi32]::BitBlt($hDC, $OffsetX - $width, 0, $width, $height, $oldhdc, 0, 0, [Gdi32]::SRCCOPY)
    [void][Gdi32]::BitBlt($hDC, 0, $OffsetY - $height, $width, $height, $oldhdc, 0, 0, [Gdi32]::SRCCOPY)
    [void][Gdi32]::BitBlt($hDC, $OffsetX - $width, $OffsetY - $height, $width, $height, $oldhdc, 0, 0, [Gdi32]::SRCCOPY)

    [void][Gdi32]::SelectObject($oldhdc, $hOldBmp)
    [void][Gdi32]::DeleteObject($hbm)
    [void][Gdi32]::DeleteDC($oldhDC)
}

function Screen-Text {
    param (
        [int]$X,
        [int]$Y,
        [string]$Text,
        [int]$Size = 20,
        [int]$Angle = 0,
        [int]$Color = 0x000000,
        [string]$FontName = "Arial",
        [int]$Weight = 400,
        [bool]$Italic = $false,
        [bool]$Underline = $false,
        [bool]$Strikeout = $false
    )
    
    $oldhDC = [Gdi32]::CreateCompatibleDC($hdc)
    
    $hFont = [Gdi32]::CreateFont(
        $Size,
        0,
        $Angle,
        $Angle,
        $Weight,
        [int]$Italic,
        [int]$Underline,
        [int]$Strikeout,
        0,
        0,
        0,
        0,
        0,
        $FontName
    )
    
    $hOldFont = [Gdi32]::SelectObject($hDC, $hFont)
    
    [void][Gdi32]::SetTextColor($hDC, $Color)
    [void][Gdi32]::SetBkMode($hDC, [Gdi32]::TRANSPARENT)
    
    [void][Gdi32]::BitBlt($oldhDC, 0, 0, $width, $height, $hDC, 0, 0, [Gdi32]::SRCCOPY)
    [void][Gdi32]::TextOut($hDC, $X, $Y, $Text, $Text.Length)
    
    [void][Gdi32]::SelectObject($hDC, $hOldFont)
    [void][Gdi32]::DeleteObject($hFont)
    [void][Gdi32]::DeleteDC($oldhDC)
}


function Ellipse {
    param (
        [int]$X,
        [int]$Y,
        [int]$Width,
        [int]$Height,
        [int]$Color,
        [int]$Stroke = 5,
        [int]$StrokeColor
    )
    
	$oldhDC = [Gdi32]::CreateCompatibleDC($hdc)
    [void][Gdi32]::SetBkMode($hDC, [Gdi32]::TRANSPARENT)
    
    $hPen = [Gdi32]::CreatePen([Gdi32]::PS_SOLID, $Stroke, $StrokeColor)
    $hOldPen = [Gdi32]::SelectObject($hDC, $hPen)
    
    $hBrush = [Gdi32]::CreateSolidBrush($Color)
    $hOldBrush = [Gdi32]::SelectObject($hDC, $hBrush)
    
    [void][Gdi32]::Ellipse($hDC, $X, $Y, $X + $Width, $Y + $Height)
    
    [void][Gdi32]::SelectObject($hDC, $hOldPen)
    [void][Gdi32]::SelectObject($hDC, $hOldBrush)
    [void][Gdi32]::DeleteObject($hPen)
    [void][Gdi32]::DeleteObject($hBrush)
    [void][Gdi32]::DeleteDC($oldhDC)
}

function Rectangle {
    param (
        [int]$X,
        [int]$Y,
        [int]$Width,
        [int]$Height,
        [int]$Color,
        [int]$Stroke = 5,
        [int]$StrokeColor
    )
    
	$oldhDC = [Gdi32]::CreateCompatibleDC($hdc)
    [void][Gdi32]::SetBkMode($hDC, [Gdi32]::TRANSPARENT)
    
    $hPen = [Gdi32]::CreatePen([Gdi32]::PS_SOLID, $Stroke, $StrokeColor)
    $hOldPen = [Gdi32]::SelectObject($hDC, $hPen)
    
    $hBrush = [Gdi32]::CreateSolidBrush($Color)
    $hOldBrush = [Gdi32]::SelectObject($hDC, $hBrush)
    
    [void][Gdi32]::Rectangle($hDC, $X, $Y, $X + $Width, $Y + $Height)
    
    [void][Gdi32]::SelectObject($hDC, $hOldPen)
    [void][Gdi32]::SelectObject($hDC, $hOldBrush)
    [void][Gdi32]::DeleteObject($hPen)
    [void][Gdi32]::DeleteObject($hBrush)
    [void][Gdi32]::DeleteDC($oldhDC)
}

function Screen-InvertRectangle {
    param (
        [int]$X,
        [int]$Y,
        [int]$Width,
        [int]$Height,
        [int]$Align = 0, # 0 - Default | 1 - Center
        [int]$ROP = $ROP_DSTINVERT
    )
	
	$oldhDC = [Gdi32]::CreateCompatibleDC($hdc)
	$ropCode = Get-ROPFromIndex -Index $ROP
    
    if ($Align -eq 1) {
        $X = $X - [math]::Floor($Width / 2)
        $Y = $Y - [math]::Floor($Height / 2)
    }

    [void][Gdi32]::PatBlt($hDC, $X, $Y, $Width, $Height, $ropCode)
    [void][Gdi32]::DeleteDC($oldhDC)
}

function Screen-DrawImage {
    param (
        [string]$Image,       	# Path to the image
        [int]$X,              	
        [int]$Y,              	
        [int]$ImageWidth = -1,	# Width to draw the image (default: -1, original width)
        [int]$ImageHeight = -1,	# Height to draw the image (default: -1, original height)
        [int]$ROP = $ROP_SRCCOPY
    )
	
	$ropCode = Get-ROPFromIndex -Index $ROP

	$oldhDC = [Gdi32]::CreateCompatibleDC($hdc)
    $bitmap = [System.Drawing.Bitmap]::FromFile($Image)

    $originalWidth = $bitmap.Width
    $originalHeight = $bitmap.Height

    if ($ImageWidth -eq -1) {
        $ImageWidth = $originalWidth
    }
    if ($ImageHeight -eq -1) {
        $ImageHeight = $originalHeight
    }

    $hBitmap = $bitmap.GetHbitmap()
    $hOldBmp = [Gdi32]::SelectObject($oldhdc, $hBitmap)

    [void][Gdi32]::StretchBlt($hDC, $X, $Y, $ImageWidth, $ImageHeight, $oldhdc, 0, 0, $originalWidth, $originalHeight, $ropCode)

    [void][Gdi32]::SelectObject($oldhdc, $hOldBmp)
    [void][Gdi32]::DeleteObject($hBitmap)
    
    [void]$bitmap.Dispose()
    [void][Gdi32]::DeleteDC($oldhDC)
}

function Screen-Waves {
	param (
        [int]$Frequency = 10,
        [int]$Amplitude = 10,
        [int]$Optimize = 2,
        [switch]$Horizontal,
        [switch]$Vertical
    )

	$oldhDC = [Gdi32]::CreateCompatibleDC($hdc)
    $hBitmap = [Gdi32]::CreateCompatibleBitmap($hDC, $width, $height)
    $hOldBitmap = [Gdi32]::SelectObject($oldhdc, $hBitmap)

    [void][Gdi32]::BitBlt($oldhdc, 0, 0, $width, $height, $hDC, 0, 0, [Gdi32]::SRCCOPY)

    $twoPiOverFreq = 2 * [math]::PI / $Frequency

    if ($Horizontal) {
        for ($y = 0; $y -lt $height; $y += $Optimize) {
            $offset = [math]::Sin($twoPiOverFreq * $y) * $Amplitude
            [void][Gdi32]::BitBlt($hDC, $offset, $y, $width - [math]::Abs($offset), $Optimize, $oldhdc, 0, $y, [Gdi32]::SRCCOPY)
        }
    }

    if ($Vertical) {
        for ($x = 0; $x -lt $width; $x += $Optimize) {
            $offset = [math]::Sin($twoPiOverFreq * $x) * $Amplitude
            [void][Gdi32]::BitBlt($hDC, $x, $offset, $Optimize, $height - [math]::Abs($offset), $oldhdc, $x, 0, [Gdi32]::SRCCOPY)
        }
    }

    [void][Gdi32]::SelectObject($oldhdc, $hOldBitmap)
    [void][Gdi32]::DeleteObject($hBitmap)
    [void][Gdi32]::DeleteDC($oldhDC)
}

function Screen-Refresh {
    [void][User32]::InvalidateRect([IntPtr]::Zero, [IntPtr]::Zero, $true)
}

function Get-RandomColor {
	return Get-Random -Minimum 0 -Maximum 0xFFFFFF
}

$ROP_SRCCOPY = 0
$ROP_SRCPAINT = 1
$ROP_SRCAND = 2
$ROP_SRCINVERT = 3
$ROP_SRCERASE = 4
$ROP_NOTSRCCOPY = 5
$ROP_NOTSRCERASE = 6
$ROP_MERGECOPY = 7
$ROP_PATCOPY = 8
$ROP_PATPAINT = 9
$ROP_PATINVERT = 10
$ROP_DSTINVERT = 11
$ROP_BLACKNESS = 12
$ROP_WHITENESS = 13

function Get-ROPFromIndex {
    param (
        [int]$Index
    )

    switch ($Index) {
        0 { return [Gdi32]::SRCCOPY }
        1 { return [Gdi32]::SRCPAINT }
        2 { return [Gdi32]::SRCAND }
        3 { return [Gdi32]::SRCINVERT }
        4 { return [Gdi32]::SRCERASE }
        5 { return [Gdi32]::NOTSRCCOPY }
        6 { return [Gdi32]::NOTSRCERASE }
        7 { return [Gdi32]::MERGECOPY }
        8 { return [Gdi32]::PATCOPY }
        9 { return [Gdi32]::PATPAINT }
        10 { return [Gdi32]::PATINVERT }
        11 { return [Gdi32]::DSTINVERT }
        12 { return [Gdi32]::BLACKNESS }
        13 { return [Gdi32]::WHITENESS }
        default { throw "Invalid ROP index" }
    }
}

function User-GetCursorPosition {
    $point = New-Object User32+POINT
    [void][User32]::GetCursorPos([ref]$point)
    return [PSCustomObject]@{
        X = $point.X
        Y = $point.Y
    }
}

function User-SetCursorPosition {
    param (
        [int]$X,
        [int]$Y
    )
    [void][User32]::SetCursorPos($X, $Y)
}

function User-DragCursor {
    param (
        [int]$Scale = 10
    )

    $mouse = User-GetCursorPosition
    $invertedScale = $Scale * -1
    $offsetX = Get-Random -Minimum $invertedScale -Maximum $Scale
    $offsetY = Get-Random -Minimum $invertedScale -Maximum $Scale
    $mouseX = $mouse.X + $offsetX
    $mouseY = $mouse.Y + $offsetY
    User-SetCursorPosition -X $mouseX -Y $mouseY

    return [PSCustomObject]@{
        X = $mouseX
        Y = $mouseY
    }
}

function User-SetDesktopBackground {
    param (
        [string]$Path
    )

    [void][User32]::SystemParametersInfo(0x0014, 0, $Path, 0x01 -bor 0x02)
}

function User-MoveWindow {
    param (
        [System.Diagnostics.Process]$ProcessObj,
        [int]$X = 0,
        [int]$Y = 0,
        [int]$Width = -1,
        [int]$Height = -1
    )

    $hwnd = $ProcessObj.MainWindowHandle

    $rect = New-Object User32+RECT
    $getRectSuccess = [User32]::GetWindowRect($hwnd, [ref]$rect)

    $currentWidth = if ($Width -eq -1) { $rect.Right - $rect.Left } else { $Width }
    $currentHeight = if ($Height -eq -1) { $rect.Bottom - $rect.Top } else { $Height }

    $moveSuccess = [User32]::MoveWindow($hwnd, $X, $Y, $currentWidth, $currentHeight, $true)

    [User32]::SetForegroundWindow($hwnd) | Out-Null
}

<#
	YOUR METHODS
	---------------------
	Define your methods here.
#>

# Nothing

<#
	RESOURCES
	----------------------
	Define your resources here.
#>

$programName = "kamushki" # Need to be same in "launcher.bat"
$currentPath = [System.IO.Path]::Combine([System.IO.Path]::GetTempPath(), $programName)

$musicPath = Get-ResourcePath -Name "music.wav" # Music

$stone1Path = Get-ResourcePath -Name "stone1.jpg"

<#
	MAIN
	---------------------
	Define your program logic. 
#>

# Define TimeKeys array with time intervals
$TimeKeys = @(6, 18, 29, 41, 53, 64, 75.5, 86, 100)



# Initialize
Release-DC -HDC $hDC
$hDC = Get-DC

Start-Process "msedge.exe" "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS_ehJKlLDlM9kOWR0Aio746GMP9d9Sizh-Pg&s"
Start-Process "msedge.exe" "https://www.terra-ekb.ru/wordpress/wp-content/uploads/Stroitelnye-kamni/Stroitelnye-kamni_(3).jpg"
Start-Process "msedge.exe" "https://sberbusiness.live/bcp-laika-public/04d02ab7-28ba-4ece-9b53-bda03e6cbe54/original"
Start-Process "msedge.exe" "https://maxim-demidov.ru/api/storage/image/105086.webp"
Start-Process "msedge.exe" "https://forpost-sz.ru/sites/default/files/styles/wide169/public/doc/2021/08/22/dol_9173-0.jpg?h=f54bfa0f&itok=biJOmHPZ"
Start-Process "msedge.exe" "https://rfland.ru/sites/default/files/styles/original/public/images/blog/stone_prirod1200.jpg?itok=Za3QJQ5S"

# Play music
$sp = Play-Audio -Path $musicPath

# Start time
$startTime = Get-Date

$refresh = 0

# Loop
while ($true) {
    $elapsedSeconds = (Get-Date) - $startTime
    $currentElapsed = $elapsedSeconds.TotalSeconds # Elapsed Seconds (Value)
	
	if ($currentElapsed -lt $TimeKeys[0]) {
		$x = Get-Random -Minimum 0 -Maximum $width
		$y = Get-Random -Minimum 0 -Maximum $height
		Screen-DrawImage -Image $stone1Path -X $x $y -ROP $ROP_SRCPAINT
		Start-Sleep -Milliseconds 5
	} elseif ($currentElapsed -lt $TimeKeys[1]) {
		for ($i = 0; $i -lt 20; $i++) {
			Screen-Waves -Frequency (Get-Random -Minimum 10 -Maximum 500) -Amplitude (Get-Random -Minimum -17 -Maximum 17) -Horizontal
			Screen-Stretch -Power (Get-Random -Minimum 4 -Maximum 20) -ROP $ROP_SRCCOPY -Inside
		}
		for ($i = 0; $i -lt 10; $i++) {
			Screen-InvertAll
			Start-Sleep -Milliseconds 50
		}
	} elseif ($currentElapsed -lt $TimeKeys[2]) {
		Screen-Pixelate -Power 2
		$x = Get-Random -Minimum 0 -Maximum $width
		$y = Get-Random -Minimum 0 -Maximum $height
		Screen-DrawImage -Image $stone1Path -X $x $y -ROP (Get-Random -Minimum 0 -Maximum 12)
	} elseif ($currentElapsed -lt $TimeKeys[3]) {
		if ($refresh -eq 0) {
			Screen-Refresh
			$refresh = 1
		}
		for ($i = 0; $i -lt 10; $i++) {
			Screen-Flip  -Horizontal
			Start-Sleep -Milliseconds 50
		}
		for ($i = 0; $i -lt 10; $i++) {
			Screen-Flip -Vertical
			Start-Sleep -Milliseconds 50
		}
	} elseif ($currentElapsed -lt $TimeKeys[4]) {	
		$x = Get-Random -Minimum 0 -Maximum $width
		$y = Get-Random -Minimum 0 -Maximum $height
		$text = "KAMUSHKII"
		Screen-Text -X $x -Y $y -Text $text -Size (Get-Random -Minimum 10 -Maximum 60) -Angle (Get-Random -Minimum 0 -Maximum 360) -Color (Get-RandomColor)
		Screen-Move -OffsetX 10 -OffsetY 20
	} elseif ($currentElapsed -lt $TimeKeys[5]) {
		for ($i = 0; $i -lt 10; $i++) {
			Screen-Flip  -Horizontal
			Start-Sleep -Milliseconds 5
		}
		for ($i = 0; $i -lt 10; $i++) {
			Screen-Flip -Vertical
			Start-Sleep -Milliseconds 5
		}
		Screen-InvertAll
	} elseif ($currentElapsed -lt $TimeKeys[6]) {
		for ($i = 0; $i -lt 10; $i++) {
			Screen-Stretch -Power 20 -ROP $ROP_SRCCOPY -OffsetX 20 -Inside
		}
		for ($i = 0; $i -lt 10; $i++) {
			Screen-Stretch -Power 20 -ROP $ROP_SRCCOPY -OffsetX (-20) -Outside
		}
		$x = Get-Random -Minimum 0 -Maximum $width
		$y = Get-Random -Minimum 0 -Maximum $height
		Screen-DrawImage -Image $stone1Path -X $x $y -ROP $ROP_DSTINVERT
	} elseif ($currentElapsed -lt $TimeKeys[7]) {
		Screen-Move -OffsetX (Get-Random -Minimum -50 -Maximum 50) -OffsetY (Get-Random -Minimum -50 -Maximum 50)
		Screen-InvertRectangle -X (Get-Random -Minimum 0 -Maximum $width) -Y (Get-Random -Minimum 0 -Maximum $height) -Width 100 -Height 100
	} elseif ($currentElapsed -lt $TimeKeys[8]) {
		Screen-Move -OffsetX (Get-Random -Minimum -50 -Maximum 50) -OffsetY (Get-Random -Minimum -50 -Maximum 50)
		Screen-InvertRectangle -X (Get-Random -Minimum 0 -Maximum $width) -Y (Get-Random -Minimum 0 -Maximum $height) -Width 100 -Height 100
		$x = Get-Random -Minimum 0 -Maximum $width
		$y = Get-Random -Minimum 0 -Maximum $height
		Screen-DrawImage -Image $stone1Path -X $x $y -ROP (Get-Random -Minimum 0 -Maximum 12)
	} else {
		break
	}
}

Release-DC -HDC $hDC
$sp.Stop()
Exit-PSHostProcess