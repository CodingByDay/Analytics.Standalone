<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="peptak._Default" %>

<%@ Register assembly="DevExpress.Dashboard.v20.2.Web.WebForms, Version=20.2.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.DashboardWeb" tagprefix="dx" %>

<%@ Register assembly="DevExpress.Web.v20.2, Version=20.2.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
    <div class="row">
             <webopt:bundlereference runat="server" path="~/css/graphs.css" />
<link href= "~/css/graphs.css" rel="stylesheet" runat="server" type="text/css" />
           <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js" type="text/javascript"></script>
<style>
    .dx-widget{  
    color: #333!important;  
    font-weight: normal!important;  
    font-size: 11px!important;  
} 
</style>
        <script>
       
           
function regex_return(text_to_search) {
    var re = /(?:^|\W)#(\w+)(?!\w)/g, match, matches = [];
    while (match = re.exec(text_to_search)) {
        matches.push(match[1]);
    }
    return matches;
}
function customizeWidgets(sender, args) {
    var parName = []
    var collection = dashboard.GetParameters().GetParameterList();
    if (args.ItemName.startsWith("gridDashboardItem") && collection.length > 2) {
        initialPayload.push(dashboard.GetParameters().GetParameterList()[0].Value);
        initialPayload.push(dashboard.GetParameters().GetParameterList()[1].Value);
        initialPayload.push(dashboard.GetParameters().GetParameterList()[2].Value);
        initialPayload.push(dashboard.GetParameters().GetParameterList()[3].Value);


        parName.push(dashboard.GetParameters().GetParameterList()[0].Name);
        parName.push(dashboard.GetParameters().GetParameterList()[1].Name);
        parName.push(dashboard.GetParameters().GetParameterList()[2].Name);
        parName.push(dashboard.GetParameters().GetParameterList()[3].Name);


        var grid = args.GetWidget();

        var columns = grid.option("columns");
        for (var i = 0; i < columns.length; i++) {
            var textToCheck = columns[i].caption;
            window.textNew = textToCheck;
            var parameterized_values = regex_return(textToCheck);
            if (parameterized_values.length != 0) {
                     // for each loop for every found parameter
                   parameterized_values.forEach((singular) => {
                   const found = parName.find(element => element == singular)
                   indexOfElement = parName.indexOf(found)

                       if (found != null && indexOfElement != -1) {
                           
                           text_to_replace = "#" + found
                           text_replace = dashboard.GetParameters().GetParameterList()[indexOfElement].Value.toLocaleDateString("uk-Uk")
                           window.textNew = window.textNew.replace(text_to_replace, text_replace);
                           console.log(window.textNew)
                           columns[i].caption = window.textNew;
                    } else {
                       
                    }
                })
            } else {
              
            }

        }
        grid.option("columns", columns);
    }
}


function updatecustomizeWidgets(sender, args) {
    var parName = []
    var collection = dashboard.GetParameters().GetParameterList();

    if (args.ItemName.startsWith("gridDashboardItem") && collection.length > 2) {

        initialPayload = [];
        initialPayload.push(dashboard.GetParameters().GetParameterList()[0].Value);
        initialPayload.push(dashboard.GetParameters().GetParameterList()[1].Value);
        initialPayload.push(dashboard.GetParameters().GetParameterList()[2].Value);
        initialPayload.push(dashboard.GetParameters().GetParameterList()[3].Value);


        parName.push(dashboard.GetParameters().GetParameterList()[0].Name);
        parName.push(dashboard.GetParameters().GetParameterList()[1].Name);
        parName.push(dashboard.GetParameters().GetParameterList()[2].Name);
        parName.push(dashboard.GetParameters().GetParameterList()[3].Name);

       
        var grid = args.GetWidget();
        var columns = grid.option("columns");
        for (var i = 0; i < columns.length; i++) {
            var textToCheck = columns[i].caption;
            window.textNew = textToCheck;

            var parameterized_values = regex_return(textToCheck);
            if (parameterized_values.length != 0) {

                // for each loop for every found parameter
                parameterized_values.forEach((singular) => {

                    const found = parName.find(element => element == singular)

                    indexOfElement = parName.indexOf(found)

                    if (found != null && indexOfElement != -1) {

                        text_to_replace = "#" + found
                        text_replace = dashboard.GetParameters().GetParameterList()[indexOfElement].Value.toLocaleDateString("uk-Uk")
                        window.textNew = window.textNew.replace(text_to_replace, text_replace);
                        console.log(window.textNew)
                        columns[i].caption = window.textNew;
                    } else {
                     
                    }
                })
            } else {
               
            }
        }
        grid.option("columns", columns);
    }
}






            function onBeforeRender(sender) {

              var dashboardControl = sender.GetDashboardControl();
              extension = new DevExpress.Dashboard.DashboardPanelExtension(dashboardControl);                
              dashboardControl.surfaceLeft(extension.panelWidth);
              dashboardControl.registerExtension(extension);

            }
            /**
             * Setting the cookie value.
             * @param cname
             * @param cvalue
             * @param exdays
             */
            function setCookie(cname, cvalue, exdays) {
                const d = new Date();
                d.setTime(d.getTime() + (exdays * 24 * 60 * 60 * 1000));
                let expires = "expires=" + d.toUTCString();
                document.cookie = cname + "=" + cvalue + ";" + expires + ";path=/";
            }



            /**
             * Getting the cookie value.
             * @param cname
             */
            function getCookie(cname) {
                let name = cname + "=";
                let decodedCookie = decodeURIComponent(document.cookie);
                let ca = decodedCookie.split(';');
                for (let i = 0; i < ca.length; i++) {
                    let c = ca[i];
                    while (c.charAt(0) == ' ') {
                        c = c.substring(1);
                    }
                    if (c.indexOf(name) == 0) {
                        return c.substring(name.length, c.length);
                    }
                }
                return "";
            }

            $(document).keypress(function (e) { if (e.keyCode === 13) { e.preventDefault(); return false; } });

            $(function () {

                $(':text').bind('keydown', function (e) { // on keydown for all textboxes  

                    if (e.keyCode == 13) // if this is enter key  

                        e.preventDefault();

                });

            }); 

            /**
             * Change the visibility of the collapsable hamburger menu. */

            function toggleVisibilityHide(toHide) {

                var picture = document.getElementById("pic")
                if (toHide == true) {

                    picture.style.visibility = "hidden"
                } else {
                    picture.style.visibility = "visible"
                }
            }


            /* Jquery function to handle hamburger clicked */

            $(document).ready(function () {
                $("#pic").mouseover(function () {

                    var expand = getCookie("expand");
                    if (expand == "true") {
                        onExpand();
                    } else {
                        var control = dashboard.GetDashboardControl();
                        design = control.isDesignMode();
                        if (design == false) {
                            onCollapse();
                        }
                    }
                 

                });

            });


            $(document).ready(function () {
                var control = dashboard.GetDashboardControl();

                

            });



            function show() {
                $('.dx-overlay-content').show();
                console.log("Show");
                $(".dx-dashboard-surface").attr('style', 'left: 250px !important');
                changePicStateHideIt(true);

            }


            function hide() {
                $('.dx-overlay-content').hide();
                console.log("hide");
                $(".dx-dashboard-surface").attr('style', 'left: 10px !important');
                changePicStateHideIt(false);
             
            }       



            function onExpand() {
                var control = dashboard.GetDashboardControl();
                extension.showPanelAsync({}).done(function (e) {
                    control.surfaceLeft(e.surfaceLeft);

                    // Helper cookie.

                    setCookie("expand", "false", 365);

                   // toggleVisibilityHide(true);

                });
            }


            function initialise() {
                control = dashboard.GetDashboardControl();
                design = control.isDesignMode();

                if (design) {
                 
                    // Pass
                } else {
                    onCollapse();
                }

            }


            function onCollapse() {

                var control = dashboard.GetDashboardControl();
          
                    extension.hidePanelAsync({}).done(function (e) {
                        control.surfaceLeft(e.surfaceLeft);
                        toggleVisibilityHide(false);
                        setCookie("expand", "true", 365);

                    });
                
            }


        </script>
    
        <div class="col-sm-12">
        <div style="position: absolute; left: 80px; right: 0; top:0; bottom:30px;">
 
</div>
        </div>
    </div>
    <div class="jumbotron">
        

</div>
   
 
<div style="position: absolute; left: 0; right: 0; top:35px; bottom:0;">
    <dx:ASPxDashboard ID="ASPxDashboard1" runat="server" AllowCreateNewJsonConnection="True"  ClientInstanceName="dashboard"  AllowExecutingCustomSql="True" AllowInspectAggregatedData="True"    MobileLayoutEnabled="Auto" AllowInspectRawData="True" DashboardStorageFolder="~/App_Data/Dashboards" EnableCustomSql="True" EnableTextBoxItemEditor="True" >
        <ClientSideEvents BeforeRender="onBeforeRender" 
                          ItemWidgetCreated="customizeWidgets"
                          ItemWidgetUpdated="updatecustomizeWidgets"    
                          DashboardInitialized="initialise"
                       
                              />
    </dx:ASPxDashboard>
</div>

   
</asp:Content>
