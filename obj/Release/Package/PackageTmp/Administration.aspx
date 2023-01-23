<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Administration.aspx.cs" Inherits="peptak.Administration" %>
<%@ Register assembly="DevExpress.Web.v21.1, Version=21.1.4.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
   
    
     <asp:PlaceHolder runat="server">
        <%: Scripts.Render("~/bundles/modernizr") %>
    </asp:PlaceHolder>

   
   


    <center><h4>Izberite uporabnika, in se odločite katere grafe lahko vidi.</h4></center>
    <hr />
    <div align="center">
    <asp:DropDownList ID="usersPermisions" autopostback="true" runat="server" OnSelectedIndexChanged="usersPermisions_SelectedIndexChanged"></asp:DropDownList>    </div>
     <center><dx:ASPxCheckBoxList ID="graphsFinal" runat="server" ValueType="System.String" Height="123px" Width="275px">
        </dx:ASPxCheckBoxList></center>
    
            
        <hr />
           <center><asp:Button type="submit" Value="Save" runat="server" ID="Save" Text="Shrani" /></center>
    
 
    



    </asp:Content>
