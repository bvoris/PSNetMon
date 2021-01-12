# PSNetMon - Camera Module
# Written by Brad Voris 
# Description: Custom Camera Module with Modl (works in Edge/IE, not compatible with other browsers)
# NO LONGER SUPPORTED

#HTML Header Coding
$HTMLHeaderCM = @"
<HTML>
    <HEAD>
    <TITLE> 
    PSNetMon - Camera Module
    </TITLE>
<LINK REL="STYLEsheet" TYPE="text/css" HREF="../css/theme.css"> 
<LINK REL="STYLEsheet" TYPE="text/css" HREF="../css/modl.css"> 
</HEAD>
"@

#Html Body Coding
$HTMLBodyCM = @"
<BODY>
<CENTER>
<DIV CLASS="page-content">

<UL ID="gallery">
	<LI>
		<A HREF="#pic-1">
			<IMG SRC="http://<IPADDRESS>/mjpeg.cgi" WIDTH="128" HEIGHT="128" ALT="" />
			<SPAN><B>Preview</b></SPAN>
		</A>
		<DIV ID="pic-1" CLASS="overlay">
			<IMG SRC="http://<IPADDRESS>/mjpeg.cgi" ALT="" />
			<DIV>
				<P>Camera 01</P>
			</DIV>
			<A HREF="#close" CLASS="prev" TITLE="Prev">&#9658;&#9658;</A>
			<A HREF="#pic-2" CLASS="next" TITLE="Next">&#9658;&#9658;</A>
			<A HREF="#close" CLASS="close" TITLE="Close">&times;</A>
		</DIV>
	</LI>
	<LI>
		<A HREF="#pic-2">
			<IMG SRC="http://<IPADDRESS>/mjpeg.cgi" WIDTH="128" HEIGHT="128" ALT="" />
			<SPAN><B>Preview</b></SPAN>
		</A>
		<DIV ID="pic-2" CLASS="overlay">
			<IMG SRC="http://<IPADDRESS>/mjpeg.cgi" ALT="" /> 
			<DIV>
				<P>Camera 02</P>
			</DIV>
			<A HREF="#pic-1" CLASS="prev" TITLE="Prev">&#9658;&#9658;</A>
			<A HREF="#pic-3" CLASS="next" TITLE="Next">&#9658;&#9658;</A>
			<A HREF="#close" CLASS="close" TITLE="Close">&times;</A>
		</DIV>
	</LI>
	<LI>
		<A HREF="#pic-3">
        <video width="128" height="128" controls>
        <source src="http://<IPADDRESS>/mjpeg.cgi" type="video/mp4">
		</Video>
			<SPAN><B>Preview</b></SPAN>
		</A>
		<DIV ID="pic-3" CLASS="overlay">
			<IMG SRC="http://<IPADDRESS>/mjpeg.cgi" ALT="" /> 
			<DIV>							
				<P>Camera 03</P>
			</DIV>
			<A HREF="#pic-2" CLASS="prev" TITLE="Prev">&#9658;&#9658;</A>
			<A HREF="#pic-4" CLASS="next" TITLE="Next">&#9658;&#9658;</A>
			<A HREF="#close" CLASS="close" TITLE="Close">&times;</A>
		</DIV>
	</LI>
</BR></BR>
	<LI>
		<A HREF="#pic-4">
			<IMG SRC="http://<IPADDRESS>/mjpeg.cgi" WIDTH="128" HEIGHT="128" ALT="" />
			<SPAN><B>Preview</b></SPAN>
		</A>
		<DIV ID="pic-4" CLASS="overlay">
			<IMG SRC="http://<IPADDRESS>/mjpeg.cgi" ALT="" />
			<DIV>							
				<P>Camera 04</P>
			</DIV>
			<A HREF="#pic-3" CLASS="prev" TITLE="Prev">&#9658;&#9658;</A>
			<A HREF="#pic-5" CLASS="next" TITLE="Next">&#9658;&#9658;</A>
			<A HREF="#close" CLASS="close" TITLE="Close">&times;</A>
		</DIV>
	</LI>
	<LI>
		<A HREF="#pic-5">
			<IMG SRC="http://<IPADDRESS>/mjpeg.cgi" WIDTH="128" HEIGHT="128" ALT="" />
			<SPAN><B>Preview</b></SPAN>
		</A>
		<DIV ID="pic-5" CLASS="overlay">
			<IMG SRC="http://<IPADDRESS>/mjpeg.cgi" ALT="" />
			<DIV>							
				<P>Camera 05</P>
			</DIV>
			<A HREF="#pic-4" CLASS="prev" TITLE="Prev">&#9658;&#9658;</A>
			<A HREF="#pic-6" CLASS="next" TITLE="Next">&#9658;&#9658;</A>
			<A HREF="#close" CLASS="close" TITLE="Close">&times;</A>
		</DIV>
	</LI>
	<LI>
		<A HREF="#pic-6">
		
			<IMG SRC="http://<IPADDRESS>/mjpeg.cgi" WIDTH="128" HEIGHT="128" ALT="" />
			<SPAN><B>Preview</b></SPAN>
		</A>
		<DIV ID="pic-6" CLASS="overlay">
			<IMG SRC="http://<IPADDRESS>/mjpeg.cgi" ALT="" />
			<DIV>							
				<P>Camera 06</P>
			</DIV>
			<A HREF="#pic-5" CLASS="prev" TITLE="Prev">&#9658;&#9658;</A>
			<A HREF="#close" CLASS="next" TITLE="Next">&#9658;&#9658;</A>
			<A HREF="#close" CLASS="close" TITLE="Close">&times;</A>
		</DIV>
	</LI>
</UL>
</DIV>
</CENTER>
</BODY>
</HTML>	
"@

#HTML Export
$Script | ConvertTo-HTML -Head $HTMLHeaderCM -Body $HTMLBodyCM  | Out-File "C:\inetpub\wwwroot\gen\cameras.html"
