# =================================================================================================================================
#
# NAME: Crypto
#
# AUTHOR : Thomas Waaler, Lærling
# DATE   : 11.08.2017
# VERSION: 1.0.0
# COMMENT: Set en kryptert nøkkel, krypter / dekrypter text
#
# =================================================================================================================================
# CHANGELOG
# =================================================================================================================================
# DATE          VERSION     BY                        COMMENT
# 11.08.2017    1.0.0       Thomas Waaler             Første utkast
# =================================================================================================================================

#-----------------------------------------------------------[Functions]------------------------------------------------------------
function Set-Key {
    param(
        [String]$String
    )

    $length = $String.Length
    $pad = 32 - $length

    if (($length -lt 16) -or ($length -gt 32)) { throw "String must be between 16 and 32 characters" }

    $encoding = New-Object System.Text.ASCIIEncoding
    $bytes = $encoding.GetBytes($String + "0" * $pad)

    return $bytes
}

function Set-EncryptedData {
    param(
        $Key,
        [String]$PlainText
    )

    $securestring = New-Object System.Security.SecureString
    $chars = $PlainText.ToCharArray()

    foreach ($char in $chars) { $securestring.AppendChar($char) }

    $encryptedData = ConvertFrom-SecureString -SecureString $securestring -Key $Key
    return $encryptedData
}

function Get-EncryptedData {
    param(
        $Key,
        $Data
    )

    $data = $data | ConvertTo-SecureString -key $key | ForEach-Object {
        [Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($_))
    }

    return $Data
}