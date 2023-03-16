function KeyPress {
    param (
        [int32]$options,
        [int32]$current = 1
    )
    do {
        if ([Console]::KeyAvailable) {

            $keyInfo = [Console]::ReadKey($true)

            if ($keyInfo.key -eq "RightArrow") {
                $keyInfo = $null
                if ($options -eq 2) {
                    if ($current -eq 1) {
                        $current = 2
                    }
                }
                if ($options -eq 3) {
                    if ($current -eq 2) {
                        $current = 3
                    }if ($current -eq 1) {
                        $current = 2
                    }
                }
                return $current
                
            }
            elseif ($keyInfo.key -eq "LeftArrow") {
                $keyInfo = $null
                if ($current -eq 2) {
                    $current = 1
                    
                }
                if ($current -eq 3) {
                    $current = 2
                    
                }
                return $current
                
                
            }
            elseif ($keyInfo.key -eq "Enter") {
                $keyInfo = $null
                if ($current -eq 2) {
                    $current = 12
                
                }
                elseif ($current -eq 1) {
                    $current = 11
                }
                elseif ($current -eq 3) {
                    $current = 13
                }
                return $current
            
            
            }
            return $current
            $keyInfo = $null
        }

    } while ($true)
    
}
function findm {
    clear-host
    Write-Host "╔══════════════════════════════════════════════════╗"
    write-host "║                                                  ║░"
    write-host "║ Enter the name of the Mailbox you're looking for ║░"
    write-host "║                                                  ║░"
    write-host "╚══════════════════════════════════════════════════╝░"
    write-host " ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░"
    write-host ""
    Write-Host "╔═Search════════════════════════════════════════════"
    write-host "╚═══> " -NoNewline
    $findname = Read-Host
    if ($findname -eq "") {
        findm
    }
    try {
        $findresults = get-mailbox "*$findname*" -ErrorAction Stop
    }
    catch {
        Write-Host ""
        write-host "No Mailbox Found, try again" -NoNewline
        Start-Sleep -Milliseconds 500
        write-host "." -NoNewline
        Start-Sleep -Milliseconds 500
        write-host "." -NoNewline
        Start-Sleep -Milliseconds 500
        write-host "." -NoNewline
        Start-Sleep -Milliseconds 500
        findm
    }
    clear-host
    write-host ""
    Write-Host "╔═Search════════════════════════════════════════════"
    write-host "╚═══> $findname"
    Write-Host ""
    for ($i = 0; $i -lt $findresults.Count; $i++) {
        try {
            $y = get-locremotemailbox "$($findresults[$i].name)" -ErrorAction stop
        }
        catch {
            $y = $null
        }
        if ($null -eq $y) {
            if ($i % 2 -eq 0 ) {
                write-host "$($i+1)  ☁️ $($findresults[$i].name)       " -BackgroundColor black
            }
            else {
                write-host "$($i+1)  ☁️ $($findresults[$i].name)       " -BackgroundColor DarkGray
            }
        }
        else {
            if ($i % 2 -eq 0 ) {
                write-host "$($i+1)  🖥️ $($findresults[$i].name)       " -BackgroundColor black
            }
            else {
                write-host "$($i+1)  🖥️ $($findresults[$i].name)       " -BackgroundColor DarkGray
            }
        }

    }
    write-host ""
    Write-Host "╔═Select════════════════════════════════════════════"
    write-host "╚═══> " -NoNewline
    $mailboxnum = Read-Host
    
    $curmail = $findresults[$mailboxnum - 1]

    $blank = 48 - $($curmail.name).length

    $curmailname = "$($curmail.name)"

    for ($i = 0; $i -lt $blank; $i++) {
        $curmailname = $curmailname + " "
    }

    try {
        $y = get-locremotemailbox "$($curmail.name)" -ErrorAction stop
    }
    catch {
        $y = $null
    }
    if ($null -eq $y) {
        $hybrid = "☁️ Cloud Only"
    }
    else {
        $hybrid = "🔗 Hybrid    "
    }

    if ($curmail.RecipientTypeDetails -eq "SharedMailbox") {
        $curmailtype = "👥 Shared"
    }
    else {
        $curmailtype = "👤 User  "
    }
    

    $option = 2
    Clear-Host
    Write-Host "╔══════════════════════════════════════════════════╗"
    write-host "║ $curmailname ║░"
    write-host "║ $hybrid                                    ║░"
    write-host "║ $curmailtype                                        ║░"
    write-host "╚══════════════════════════════════════════════════╝░"
    write-host " ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░"
    Write-Host ""

    write-host "       ╔═══════════════════╗   "
    write-host " ╔═══╗ ║ 🕵️ Aliases        ║░  ╔═══════════════════╗"
    write-host " ║ < ║ ╚═══════════════════╝░  ║  🔑 Permissions   ║"
    write-host " ╚═══╝  ░░░░░░░░░░░░░░░░░░░░░  ╚═══════════════════╝"


    for ($i = $option; $i -lt 13; $i) {
        $i = KeyPress -options 3 -current $i
        if ($i -eq 2) {
            Clear-Host
            Write-Host "╔══════════════════════════════════════════════════╗"
            write-host "║ $curmailname ║░"
            write-host "║ $hybrid                                    ║░"
            write-host "║ $curmailtype                                        ║░"
            write-host "╚══════════════════════════════════════════════════╝░"
            write-host " ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░"
            Write-Host ""

            write-host "       ╔═══════════════════╗   "
            write-host " ╔═══╗ ║ 🕵️ Aliases        ║░  ╔═══════════════════╗"
            write-host " ║ < ║ ╚═══════════════════╝░  ║  🔑 Permissions   ║"
            write-host " ╚═══╝  ░░░░░░░░░░░░░░░░░░░░░  ╚═══════════════════╝"
            $option = $i
        }
        elseif ($i -eq 3) {
            Clear-Host
            Write-Host "╔══════════════════════════════════════════════════╗"
            write-host "║ $curmailname ║░"
            write-host "║ $hybrid                                    ║░"
            write-host "║ $curmailtype                                        ║░"
            write-host "╚══════════════════════════════════════════════════╝░"
            write-host " ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░"
            Write-Host ""

            write-host "                              ╔═══════════════════╗"
            write-host " ╔═══╗  ╔═══════════════════╗ ║  🔑 Permissions   ║░"
            write-host " ║ < ║  ║ 🕵️ Aliases        ║ ╚═══════════════════╝░"
            write-host " ╚═══╝  ╚═══════════════════╝  ░░░░░░░░░░░░░░░░░░░░░" 
            $option = $i
        }
        elseif ($i -eq 1) {
            Clear-Host
            Write-Host "╔══════════════════════════════════════════════════╗"
            write-host "║ $curmailname ║░"
            write-host "║ $hybrid                                    ║░"
            write-host "║ $curmailtype                                        ║░"
            write-host "╚══════════════════════════════════════════════════╝░"
            write-host " ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░"
            Write-Host ""

            write-host "╔═══╗                              "
            write-host "║ < ║░  ╔═══════════════════╗  ╔═══════════════════╗"
            write-host "╚═══╝░  ║ 🕵️ Aliases        ║  ║  🔑 Permissions   ║"
            write-host " ░░░░░  ╚═══════════════════╝  ╚═══════════════════╝" 
            $option = $i
        }
        elseif ($i -eq 11) {
            Clear-Host
            write-host "╔═══════════════════╗   "
            write-host "║ 🔎 Find a mailbox ║░  ╔═══════════════════╗"
            write-host "╚═══════════════════╝░  ║ 📃 View Summary   ║"
            write-host " ░░░░░░░░░░░░░░░░░░░░░  ╚═══════════════════╝"
            mainmenu
        }
        elseif ($i -eq 12) {
            $option = 2
            Clear-Host
            Write-Host "╔══════════════════════════════════════════════════╗"
            write-host "║ $curmailname ║░"
            write-host "║ $hybrid                  ╔═════════════════╣░"
            write-host "║ $curmailtype                      ║   🕵️ Aliases    ║░"
            write-host "╚════════════════════════════════╩═════════════════╝░"
            write-host " ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░"
            Write-Host ""
            write-host "       ╔═══════════════════╗   "
            write-host " ╔═══╗ ║   ➕ New Alias    ║░  ╔═══════════════════╗"
            write-host " ║ < ║ ╚═══════════════════╝░  ║  ❌ Remove Alias  ║"
            write-host " ╚═══╝  ░░░░░░░░░░░░░░░░░░░░░  ╚═══════════════════╝"
            write-host ""
            $alias = $(((get-mailbox "$($curmail.name)").emailaddresses | ? { $_ -match "smtp:" }).substring(5))

            for ($i = 0; $i -lt $alias.Count; $i++) {

                if ($i % 2 -eq 0 ) {
                    write-host "$($i+1)  ☁️ $($alias[$i])       " -BackgroundColor black
                }
                else {
                    write-host "$($i+1)  ☁️ $($alias[$i])       " -BackgroundColor DarkGray
                }
        
            }

            for ($i = $option; $i -lt 13; $i) {
                $i = KeyPress -options 3 -current $i
                if ($i -eq 2) {
                    Clear-Host
                    Write-Host "╔══════════════════════════════════════════════════╗"
                    write-host "║ $curmailname ║░"
                    write-host "║ $hybrid                  ╔═════════════════╣░"
                    write-host "║ $curmailtype                      ║   🕵️ Aliases    ║░"
                    write-host "╚════════════════════════════════╩═════════════════╝░"
                    write-host " ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░"
                    Write-Host ""
        
                    write-host "       ╔═══════════════════╗   "
                    write-host " ╔═══╗ ║   ➕ New Alias    ║░  ╔═══════════════════╗"
                    write-host " ║ < ║ ╚═══════════════════╝░  ║  ❌ Remove Alias  ║"
                    write-host " ╚═══╝  ░░░░░░░░░░░░░░░░░░░░░  ╚═══════════════════╝"
                    Write-Host ""
                    $option = $i
                    for ($w = 0; $w -lt $alias.Count; $w++) {

                        if ($w % 2 -eq 0 ) {
                            write-host "$($w+1)  ☁️ $($alias[$w])       " -BackgroundColor black
                        }
                        else {
                            write-host "$($w+1)  ☁️ $($alias[$w])       " -BackgroundColor DarkGray
                        }
                
                    }
                }
                elseif ($i -eq 3) {
                    Clear-Host
                    Write-Host "╔══════════════════════════════════════════════════╗"
                    write-host "║ $curmailname ║░"
                    write-host "║ $hybrid                  ╔═════════════════╣░"
                    write-host "║ $curmailtype                      ║   🕵️ Aliases    ║░"
                    write-host "╚════════════════════════════════╩═════════════════╝░"
                    write-host " ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░"
                    Write-Host ""
        
                    write-host "                              ╔═══════════════════╗"
                    write-host " ╔═══╗  ╔═══════════════════╗ ║  ❌ Remove Alias  ║░"
                    write-host " ║ < ║  ║   ➕ New Alias    ║ ╚═══════════════════╝░"
                    write-host " ╚═══╝  ╚═══════════════════╝  ░░░░░░░░░░░░░░░░░░░░░" 
                    write-host ""
                    $option = $i
                    for ($s = 0; $s -lt $alias.Count; $s++) {

                        if ($s % 2 -eq 0 ) {
                            write-host "$($s+1)  ☁️ $($alias[$s])       " -BackgroundColor black
                        }
                        else {
                            write-host "$($s+1)  ☁️ $($alias[$s])       " -BackgroundColor DarkGray
                        }
                
                    }
                }
                elseif ($i -eq 1) {
                    Clear-Host
                    Write-Host "╔══════════════════════════════════════════════════╗"
                    write-host "║ $curmailname ║░"
                    write-host "║ $hybrid                  ╔═════════════════╣░"
                    write-host "║ $curmailtype                      ║   🕵️ Aliases    ║░"
                    write-host "╚════════════════════════════════╩═════════════════╝░"
                    write-host " ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░"
                    Write-Host ""
        
                    write-host "╔═══╗                              "
                    write-host "║ < ║░  ╔═══════════════════╗  ╔═══════════════════╗"
                    write-host "╚═══╝░  ║   ➕ New Alias    ║  ║  ❌ Remove Alias  ║"
                    write-host " ░░░░░  ╚═══════════════════╝  ╚═══════════════════╝" 
                    $option = $i
                    write-host ""
                    for ($t = 0; $t -lt $alias.Count; $t++) {

                        if ($t % 2 -eq 0 ) {
                            write-host "$($t+1)  ☁️ $($alias[$t])       " -BackgroundColor black
                        }
                        else {
                            write-host "$($t+1)  ☁️ $($alias[$t])       " -BackgroundColor DarkGray
                        }
                
                    }
                }
                elseif ($i -eq 11) {
                    Clear-Host
                    write-host "╔═══════════════════╗   "
                    write-host "║ 🔎 Find a mailbox ║░  ╔═══════════════════╗"
                    write-host "╚═══════════════════╝░  ║ 📃 View Summary   ║"
                    write-host " ░░░░░░░░░░░░░░░░░░░░░  ╚═══════════════════╝"
                    mainmenu
                }
                elseif ($i -eq 12) {
                    Clear-Host
                    Write-Host "╔══════════════════════════════════════════════════╗"
                    write-host "║ $curmailname ║░"
                    write-host "║ $hybrid                  ╔═════════════════╣░"
                    write-host "║ $curmailtype                      ║   🕵️ Aliases    ║░"
                    write-host "╚════════════════════════════════╩═════════════════╝░"
                    write-host " ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░"
                    Write-Host ""
                    write-host "       ╔═══════════════════╗   "
                    write-host " ╔═══╗ ║   ➕ New Alias    ║░  ╔═══════════════════╗"
                    write-host " ║ < ║ ╚═══════════════════╝░  ║  ❌ Remove Alias  ║"
                    write-host " ╚═══╝  ░░░░░░░░░░░░░░░░░░░░░  ╚═══════════════════╝"
                }
                elseif ($i -eq 13) {
                    Clear-Host
                    Write-Host "╔══════════════════════════════════════════════════╗"
                    write-host "║ $curmailname ║░"
                    write-host "║ $hybrid                  ╔═════════════════╣░"
                    write-host "║ $curmailtype                      ║   🕵️ Aliases    ║░"
                    write-host "╚════════════════════════════════╩═════════════════╝░"
                    write-host " ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░"
                    Write-Host ""
        
                    write-host "                              ╔═══════════════════╗"
                    write-host " ╔═══╗  ╔═══════════════════╗ ║  ❌ Remove Alias  ║░"
                    write-host " ║ < ║  ║   ➕ New Alias    ║ ╚═══════════════════╝░"
                    write-host " ╚═══╝  ╚═══════════════════╝  ░░░░░░░░░░░░░░░░░░░░░" 
                    write-host ""
                    $option = $i
                    for ($s = 0; $s -lt $alias.Count; $s++) {

                        if ($s % 2 -eq 0 ) {
                            write-host "$($s+1)  ☁️ $($alias[$s])       " -BackgroundColor black
                        }
                        else {
                            write-host "$($s+1)  ☁️ $($alias[$s])       " -BackgroundColor DarkGray
                        }
                
                    }
                    write-host ""
                    Write-Host "╔═Select════════════════════════════════════════════"
                    write-host "╚═══> " -NoNewline
                    $aliasnum = Read-Host
                    Get-locRemoteMailbox "jacob petrie" | Set-locRemoteMailbox -EmailAddresses @{remove=(((get-mailbox "jacob petrie").emailaddresses | ? {$_ -match "smtp:"}).substring(5))[$aliasnum-1]}
                    Write-Host ""
                    write-host "This change could take up to 30 mins to apply" -NoNewline
                    Start-Sleep -Milliseconds 500
                    write-host "." -NoNewline
                    Start-Sleep -Milliseconds 500
                    write-host "." -NoNewline
                    Start-Sleep -Milliseconds 500
                    write-host "." -NoNewline
                    Start-Sleep -Milliseconds 500
                    Clear-Host
                    write-host "╔═══════════════════╗   "
                    write-host "║ 🔎 Find a mailbox ║░  ╔═══════════════════╗"
                    write-host "╚═══════════════════╝░  ║ 📃 View Summary   ║"
                    write-host " ░░░░░░░░░░░░░░░░░░░░░  ╚═══════════════════╝"
                    mainmenu

                }


            }
            elseif ($i -eq 13) {
                "selected alias"
                Start-Sleep -Seconds 10
            }

        }
        #break
    }

}
function mainmenu {
    do {
        # wait for a key to be available:
        if ([Console]::KeyAvailable) {
            # read the key, and consume it so it won't
            # be echoed to the console:
            $keyInfo = [Console]::ReadKey($true)
            # exit loop
            if ($keyInfo.key -eq "RightArrow") {
                $keyInfo = $null
                if ($maincurop -eq 1) {
                    $maincurop = 2
                }
                break
                
            }
            elseif ($keyInfo.key -eq "LeftArrow") {
                $keyInfo = $null
                if ($maincurop -eq 2) {
                    $maincurop = 1
                }
                break
                
                
            }
            elseif ($keyInfo.key -eq "Enter") {
                $keyInfo = $null
                if ($maincurop -eq 1) {
                    findm
                }
                elseif ($maincurop -eq 2) {
                    #do view summary things
                }
                
            }
            $keyInfo = $null
        }

    } while ($true)

    Clear-Host
    if ($maincurop -eq 1) {
        write-host "╔═══════════════════╗   "
        write-host "║ 🔎 Find a mailbox ║░  ╔═══════════════════╗"
        write-host "╚═══════════════════╝░  ║ 📃 View Summary   ║"
        write-host " ░░░░░░░░░░░░░░░░░░░░░  ╚═══════════════════╝"

    }
    elseif ($maincurop -eq 2) {
        write-host "                       ╔═══════════════════╗"
        write-host " ╔═══════════════════╗ ║ 📃 View Summary   ║░"
        write-host " ║ 🔎 Find a mailbox ║ ╚═══════════════════╝░"
        write-host " ╚═══════════════════╝  ░░░░░░░░░░░░░░░░░░░░░"  
    }

}

$cloudmod = get-module "tmpEXO*"
if ($null -eq $cloudmod) {
    clear-host
    Write-Host "╔══════════════════════════════════════════════════╗"
    write-host "║                                                  ║░"
    write-host "║ 🖥️ >> 📬 Connecting to the On-Premise Exchange   ║░"
    write-host "║                                                  ║░"
    write-host "╚══════════════════════════════════════════════════╝░"
    write-host " ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░"
    Write-Host ""
    # Setting Up On-Prem Exchange
    $cred = Get-Credential


    Write-host "Local Exchange Server: " -NoNewline
    $lochost = Read-Host

    try {
        $mx = new-pssession -ConfigurationName Microsoft.Exchange -ConnectionUri http://$lochost/Powershell/ -Authentication Kerberos -Credential $cred -ErrorAction Stop
    }
    catch {
        write-host "Username or Password Incorrect, try again"
        $cred = Get-Credential
        $mx = new-pssession -ConfigurationName Microsoft.Exchange -ConnectionUri http://$lochost/Powershell/ -Authentication Kerberos -Credential $cred
    }
    Import-PSSession $mx -DisableNameChecking -Prefix loc 
    write-host ""
    Write-Host "╔══════════════════════════════════════════════════╗"
    write-host "║                                                  ║░"
    write-host "║  🖥️ >> ☁️    Connecting to the Cloud Exchange    ║░"
    write-host "║                                                  ║░"
    write-host "╚══════════════════════════════════════════════════╝░"
    write-host " ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░"
    Write-Host ""
    # Setting Up Online Exchange
    try { Connect-ExchangeOnline }
    catch { 
        Install-Module -Name ExchangeOnlineManagement
        Connect-ExchangeOnline
    }


}

clear-host
write-host "╔═══════════════════╗   "
write-host "║ 🔎 Find a mailbox ║░  ╔═══════════════════╗"
write-host "╚═══════════════════╝░  ║ 📃 View Summary   ║"
write-host " ░░░░░░░░░░░░░░░░░░░░░  ╚═══════════════════╝"
$maincurop = 1

do {
    mainmenu
}while ($true)
