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

            function onItemCaptionToolbarUpdated(s, e) {

                var list = dashboard.GetParameters().GetParameterList();
                setCookie("params", JSON.stringify(list), 365);
                if (list.length > 0) {
                    window.item_caption = e.Options.staticItems[0].text;
                    var parameterized_values = regex_return(item_caption);
                    if (parameterized_values.length != 0) {
                        parameterized_values.forEach((singular) => {
                            const found = list.find(element => element.Name == singular)
                            indexOfElement = list.indexOf(found)
                            if (found != null && indexOfElement != -1) {
                                text_to_replace = "#" + found.Name
                                try {
                                    text_replace = dashboard.GetParameters().GetParameterList()[indexOfElement].Value.toLocaleDateString("uk-Uk")
                                } catch (err) {
                                    text_replace = dashboard.GetParameters().GetParameterList()[indexOfElement].Value
                                }
                                window.item_caption = window.item_caption.replace(text_to_replace, text_replace);
                                e.Options.staticItems[0].text = window.item_caption;
                            }
                        })
                    }

                }
            }
           
function regex_return(text_to_search) {
    var re = /(?:^|\W)#(\w+)(?!\w)/g, match, matches = [];
    while (match = re.exec(text_to_search)) {
        matches.push(match[1]);
    }
    return matches;
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


            initialPayload = [];
            updatedPayload = [];
            /**
             * A client side event to update the column header titles based on parameter values.
             * @param sender
             * @param args
             */

            function onItemCaptionToolbarUpdated(s, e) {

                var list = dashboard.GetParameters().GetParameterList();
                setCookie("params", JSON.stringify(list), 365);
                if (list.length > 0) {
                    window.item_caption = e.Options.staticItems[0].text;
                    var parameterized_values = regex_return(item_caption);
                    if (parameterized_values.length != 0) {
                        parameterized_values.forEach((singular) => {
                            const found = list.find(element => element.Name == singular)
                            indexOfElement = list.indexOf(found)
                            if (found != null && indexOfElement != -1) {
                                text_to_replace = "#" + found.Name
                                try {
                                    text_replace = dashboard.GetParameters().GetParameterList()[indexOfElement].Value.toLocaleDateString("uk-Uk")
                                } catch (err) {
                                    text_replace = dashboard.GetParameters().GetParameterList()[indexOfElement].Value
                                }
                                window.item_caption = window.item_caption.replace(text_to_replace, text_replace);
                                e.Options.staticItems[0].text = window.item_caption;
                            }
                        })
                    }

                }
            }






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

                if (args.ItemName.startsWith("gridDashboardItem") && collection.length > 3) {
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

                            parameterized_values.forEach((singular) => {
                                const found = parName.find(element => element == singular)
                                indexOfElement = parName.indexOf(found)

                                if (found != null && indexOfElement != -1) {

                                    text_to_replace = "#" + found
                                    try {
                                        text_replace = dashboard.GetParameters().GetParameterList()[indexOfElement].Value.toLocaleDateString("uk-Uk")
                                    } catch (err) {
                                        text_replace = dashboard.GetParameters().GetParameterList()[indexOfElement].Value
                                    }
                                    window.textNew = window.textNew.replace(text_to_replace, text_replace);
                                    columns[i].caption = window.textNew;
                                }
                            })
                        }

                    }
                    grid.option("columns", columns);
                }



                if (args.ItemName.startsWith("chart")) {
                    var chart = args.GetWidget();

                    let tip = chart.tooltip =
                    {
                        enabled: true,
                        customizeTooltip(arg) {
                            let rWork = arg.seriesName;
                            window.item_caption = rWork;
                            var list = dashboard.GetParameters().GetParameterList();
                            if (list.length > 0) {

                                var parameterized_values = regex_return(arg.seriesName);
                                if (parameterized_values.length != 0) {
                                    parameterized_values.forEach((singular) => {
                                        const found = list.find(element => element.Name == singular)
                                        indexOfElement = list.indexOf(found)
                                        if (found != null && indexOfElement != -1) {
                                            text_to_replace = "#" + found.Name
                                            try {
                                                text_replace = dashboard.GetParameters().GetParameterList()[indexOfElement].Value.toLocaleDateString("uk-Uk")
                                            } catch (err) {
                                                text_replace = dashboard.GetParameters().GetParameterList()[indexOfElement].Value
                                            }
                                            window.item_caption = window.item_caption.replace(text_to_replace, text_replace);
                                            console.log(window.item_caption);

                                        }
                                    })
                                }

                            }
                            var splited = window.item_caption.split(" ");
                            splited_removed = removeItemOnce(splited)
                            let replaced = splited_removed.join(" ");



                            return {
                                text: `${replaced}: ${arg.valueText}`,
                            };
                        }

                    };
                    chart.option("tooltip", tip);
        


                    var legend = chart.option("legend");
                    legend.customizeText = function (arg) {
                        window.item_caption = arg.seriesName;
                        var list = dashboard.GetParameters().GetParameterList();
                        if (list.length > 0) {

                            var parameterized_values = regex_return(arg.seriesName);
                            if (parameterized_values.length != 0) {
                                parameterized_values.forEach((singular) => {
                                    const found = list.find(element => element.Name == singular)
                                    indexOfElement = list.indexOf(found)
                                    if (found != null && indexOfElement != -1) {
                                        text_to_replace = "#" + found.Name
                                        try {
                                            text_replace = dashboard.GetParameters().GetParameterList()[indexOfElement].Value.toLocaleDateString("uk-Uk")
                                        } catch (err) {
                                            text_replace = dashboard.GetParameters().GetParameterList()[indexOfElement].Value
                                        }
                                        window.item_caption = window.item_caption.replace(text_to_replace, text_replace);
                                        console.log(window.item_caption);

                                    }
                                })
                            }

                        }
                        var splited = window.item_caption.split(" ");
                        splited_removed = removeItemOnce(splited)
                        return splited_removed.join(" ");
                    }
                    chart.option("legend", legend);

                }
            }
            function removeItemOnce(arr) {

                arr.splice(0, 1);

                return arr;
            }

            function updatecustomizeWidgets(sender, args) {
                // update

                var parName = []
                var collection = dashboard.GetParameters().GetParameterList();

                setCookie('new', JSON.stringify(collection))


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

                            parameterized_values.forEach((singular) => {
                                const found = parName.find(element => element == singular)
                                indexOfElement = parName.indexOf(found)
                                if (found != null && indexOfElement != -1) {

                                    text_to_replace = "#" + found
                                    try {
                                        text_replace = dashboard.GetParameters().GetParameterList()[indexOfElement].Value.toLocaleDateString("uk-Uk")
                                    } catch (err) {
                                        text_replace = dashboard.GetParameters().GetParameterList()[indexOfElement].Value
                                    }
                                    window.textNew = window.textNew.replace(text_to_replace, text_replace);
                                    columns[i].caption = window.textNew;
                                }
                            })
                        }
                    }
                    grid.option("columns", columns);
                }
                var items = dashboard.GetDashboardControl().dashboard().items();
                tabItems = []
                window.counter = 0;
                d_old = JSON.parse(getCookie('old'));
                d_new = JSON.parse(getCookie('new'));
                console.log(d_old);
                console.log(d_new);
                for (var i = 0; i < items.length; i++) {
                    var iCurrent = items[i];
                    item_caption = iCurrent.name();
                    for (var j = 0; j < collection.length; j++) {
                        var sDate = new Date(d_old[j].Value).toLocaleDateString("uk-Uk");
                        if (iCurrent.name().includes(sDate)) {
                            old_v = new Date(d_old[j].Value).toLocaleDateString("uk-Uk");
                            new_v = new Date(d_new[j].Value).toLocaleDateString("uk-Uk");
                            var nName = iCurrent.name().replace(old_v, new_v);
                            iCurrent.name(nName);
                        }
                    }
                }


                if (args.ItemName.startsWith("chart")) {
                    var chart = args.GetWidget();
     

                    var legend = chart.option("legend");
                    legend.customizeText = function (arg) {
                        window.item_caption = arg.seriesName;
                        var list = dashboard.GetParameters().GetParameterList();
                        if (list.length > 0) {

                            var parameterized_values = regex_return(arg.seriesName);
                            if (parameterized_values.length != 0) {
                                parameterized_values.forEach((singular) => {
                                    const found = list.find(element => element.Name == singular)
                                    indexOfElement = list.indexOf(found)
                                    if (found != null && indexOfElement != -1) {
                                        text_to_replace = "#" + found.Name
                                        try {
                                            text_replace = dashboard.GetParameters().GetParameterList()[indexOfElement].Value.toLocaleDateString("uk-Uk")
                                        } catch (err) {
                                            text_replace = dashboard.GetParameters().GetParameterList()[indexOfElement].Value
                                        }
                                        window.item_caption = window.item_caption.replace(text_to_replace, text_replace);
                                        console.log(window.item_caption);

                                    }
                                })
                            }

                        }
                        var splited = window.item_caption.split(" ");
                        splited_removed = removeItemOnce(splited)
                        return splited_removed.join(" ");
                    }
                    chart.option("legend", legend);

                }
            }




            payload = [];

            var extension;

            /**
             *  
             * @param sender
             */

            function onBeforeRender(sender) {

                var dashboardControl = sender.GetDashboardControl();
                extension = new DevExpress.Dashboard.DashboardPanelExtension(dashboardControl);
                dashboardControl.surfaceLeft(extension.panelWidth);
                dashboardControl.registerExtension(extension);
                dashboardControl.registerExtension(new SaveAsDashboardExtension(dashboardControl));

            }

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
                    setCookie("expand", "false", 365);

                });
            }




            function onCollapse() {

                var control = dashboard.GetDashboardControl();
                extension.hidePanelAsync({}).done(function (e) {
                    control.surfaceLeft(e.surfaceLeft);
                    toggleVisibilityHide(false);
                    setCookie("expand", "true", 365);

                });
            }

            function correctTheLoadingState(s, e) {
                var control = dashboard.GetDashboardControl();

                design = control.isDesignMode();

                if (design == false) {
                    onCollapse();
                }

                var list = dashboard.GetParameters().GetParameterList();
                setCookie('old', JSON.stringify(list))
                setCookie('new', JSON.stringify(list))

                var control = dashboard.GetDashboardControl();
                var items = s.GetDashboardControl().dashboard().items();
                tabItems = []
                window.counter = 0;


                for (var i = 0; i < items.length; i++) {
                    var iCurrent = items[i];
                    item_caption = iCurrent.name();
                    var parameterized_values = regex_return(item_caption);
                    if (parameterized_values.length != 0) {
                        parameterized_values.forEach((singular) => {

                            const found = list.find(element => element.Name == singular)
                            indexOfElement = list.indexOf(found)

                            if (found != null && indexOfElement != -1) {
                                text_to_replace = "#" + found.Name;

                                try {
                                    text_replace = dashboard.GetParameters().GetParameterList()[indexOfElement].Value.toLocaleDateString("uk-Uk")
                                } catch (err) {
                                    text_replace = dashboard.GetParameters().GetParameterList()[indexOfElement].Value
                                }
                                window.item_caption = window.item_caption.replace(text_to_replace, text_replace);

                                iCurrent.name(window.item_caption);
                            }
                        })
                    }

                }


            }

            function ClickButton() {
                var clickButton = document.getElementById("<%= hiddenButton.ClientID %>");
                clickButton.click();

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
     <script type="text/html" id="dx-save-as-form">

        <div>Dashboard Name:</div>
        <div style="margin: 10px 0" data-bind="dxTextBox: { value: newName }"></div>
        <div data-bind="dxButton: { text: 'Save', onClick: saveAs }"></div>
         </script>
        <div class="col-sm-12">
        <div style="position: absolute; left: 80px; right: 0; top:0; bottom:30px;">
 
</div>
        </div>
    </div>
    <div class="jumbotron">
        

</div>
     <script src="js/SaveAsExtension.js" type="text/javascript"></script>
    <div hidden>
     <asp:Button ID="hiddenButton" runat="server"  OnClick ="hiddenButton_Click" />
</div>
<div style="position: absolute; left: 0; right: 0; top:35px; bottom:0;">
    <dx:ASPxDashboard ID="ASPxDashboard1" runat="server" AllowCreateNewJsonConnection="True"  ClientInstanceName="dashboard"  AllowExecutingCustomSql="True" AllowInspectAggregatedData="True"    MobileLayoutEnabled="Auto" AllowInspectRawData="True" DashboardStorageFolder="~/App_Data/Dashboards" EnableCustomSql="True" EnableTextBoxItemEditor="True" >
        <ClientSideEvents BeforeRender="onBeforeRender" 
			                ItemCaptionToolbarUpdated="onItemCaptionToolbarUpdated" 
                          ItemWidgetCreated="customizeWidgets"
                           
                          ItemWidgetUpdated="updatecustomizeWidgets"                   
                          DashboardInitialized="correctTheLoadingState" 
                       
                              />
    </dx:ASPxDashboard>
</div>

   
</asp:Content>
