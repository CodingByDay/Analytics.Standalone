﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Logon.aspx.cs" Inherits="peptak.Logon" %>

<!DOCTYPE html>
    <link href="/css/custom.css" rel="stylesheet" type="text/css" />

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>



<body>



         <style>
         /* Smartphones (portrait and landscape) ----------- */

.login {
    text-align: center!important;
    min-width: 60%!important;
    max-width: 60%!important;
}

     #form1 {
         width: 100%!important;
         height: 100%!important;
     }

    </style>


    <div class="wrapper fadeInDown">
        <div id="formContent">
            <form id="form1" runat="server">
                <div>
                             <div class="formTitle">Analytics<br /><span class="formSubTitle">Analytics by In.SIST d.o.o.</span></div>


                    <input id="txtUserName" type="text" runat="server">
                    <asp:RequiredFieldValidator ControlToValidate="txtUserName"
                        Display="Static" ErrorMessage="*" runat="server"
                        ID="vUserName" />

                    <input id="txtUserPass" type="password" runat="server">
                    <asp:RequiredFieldValidator ControlToValidate="txtUserPass"
                        Display="Static" ErrorMessage="*" runat="server"
                        ID="vUserPass" />
                    <br />

                    <div class="center">
                        <span style="color: #808080;">Zapomni si prijavo</span>
                        <asp:CheckBox ID="chkPersistCookie" runat="server" AutoPostBack="false" />
                        <p>
                            <asp:Button ID="cmdLogin" runat="server" Text="Prijava" type="submit" OnClick="cmdLogin_Click" />
                    </div>
                    </p>
                    <asp:Label ID="lblMsg" ForeColor="red" Font-Name="Verdana" Font-Size="10" runat="server" />
                </div>
            </form>
        </div>
    </div>
</body>
</html>
