<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="peptak._Default" %>

<%@ Register assembly="DevExpress.Dashboard.v23.2.Web.WebForms, Version=23.2.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.DashboardWeb" tagprefix="dx" %>

<%@ Register assembly="DevExpress.Web.v23.2, Version=23.2.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
    <div class="row">
             <webopt:bundlereference runat="server" path="~/css/graphs.css" />
<link href= "~/css/graphs.css" rel="stylesheet" runat="server" type="text/css" />
           <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js" type="text/javascript"></script>
                <script src="js/DeleteExtension.js"></script>

<style>
    .dx-widget{  
    color: #333!important;  
    font-weight: normal!important;  
    font-size: 11px!important;  
} 
</style>
<script type="text/javascript">


            function refreshToolbar() {
            }


           


            var contextMenu = false;
            window.oncontextmenu = function (e) {
                var x = e.pageX;
                var y = e.pageY;

                var frompoint = document.elementsFromPoint(x, y);
                var dash = frompoint[1].textContent.trim();
                if (dash.length < 50 && x <= 250) {
                    if (confirm(`Odpri ${dash} v novi kartici?`)) {
                        setCookie("tab", dash, 365);
                        NewTab(dash);
                    }
                    e.preventDefault();
                }
            }
            function NewTab(dash) {
                window.open(
                    `http://dashboard.in-sist.si:81/Default.aspx?p=${dash}`, "_blank");
            }


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




            //function onBeforeRender(sender) {

            //  var dashboardControl = sender.GetDashboardControl();
            //  extension = new DevExpress.Dashboard.DashboardPanelExtension(dashboardControl);
            //  dashboardControl.surfaceLeft(extension.panelWidth);
            //  dashboardControl.registerExtension(extension);

            //}
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
                $(".dx-dashboard-surface").attr('style', 'left: 250px !important');
                changePicStateHideIt(true);

            }


            function hide() {
                $('.dx-overlay-content').hide();
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

                // Way to solve the issue. Save the original string with the parameters somewhere
                // and then before save return it from that object in that way changed value will
                // only appear to the user.

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



            var global_test = 0;


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
                if (args.ItemName.startsWith("gridDashboardItem") && collection.length > 0) {
                    for (var j = 0; j < collection.length; j++) {
                        initialPayload.push(dashboard.GetParameters().GetParameterList()[j].Value);
                        parName.push(dashboard.GetParameters().GetParameterList()[j].Name);
                    }
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

                                        }
                                    })
                                }

                            }
                            var splited = window.item_caption.split(" ");
                            splited_removed = removeItemOnce(splited)
                            let replaced = splited_removed.join("");



                            return {
                                text: `${window.item_caption}: ${arg.valueText}`,
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

                                    }
                                })
                            }

                        }
                        var splited = window.item_caption.split("series__");
                        splited_removed = removeItemOnce(splited);
                        var f = window.item_caption.replace("__legend__series__", "")
                        return f;
                    }
                    chart.option("legend", legend);

                } else if (args.ItemName.startsWith("pieMap")) {
                    try {
                        var elms = document.getElementsByClassName("dxm-legend")
                        var texts = elms[0].getElementsByTagName("text")
                        for (var i = 0; i < texts.length; i++) {
                            var inner = texts[i];


                            var list = dashboard.GetParameters().GetParameterList();
                            if (list.length > 0) {

                                var parameterized_values = regex_return(inner.innerHTML);
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
                                            inner.innerHTML = inner.innerHTML.replace(text_to_replace, text_replace);

                                        }
                                    })
                                }

                            }
                        }

                    } catch (err) {

                    }

                }
            }

            function removeItemOnce(arr) {
                arr.splice(0, 1);

                return arr;
            }

            window.widget = []

            function updatecustomizeWidgets(sender, args) {
                // update
                // this runs when parameters are changed TODO
                var parName = []
                var collection = dashboard.GetParameters().GetParameterList();

                setCookie('new', JSON.stringify(collection))

                window.widget.push(args.GetWidget());

                if (args.ItemName.startsWith("gridDashboardItem") && collection.length > 0) {
                    initialPayload = [];
                    for (var j = 0; j < collection.length; j++) {
                        initialPayload.push(dashboard.GetParameters().GetParameterList()[j].Value);
                        parName.push(dashboard.GetParameters().GetParameterList()[j].Name);
                    }
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
                // here is the error
                tabItems = []
                window.counter = 0;

                d_old = JSON.parse(getCookie('old'));
                d_new = JSON.parse(getCookie('new'));

                for (var i = 0; i < items.length; i++) {
                    var iCurrent = items[i];
                    item_caption = iCurrent.name();
                    for (var j = 0; j < collection.length; j++) {
                        try {
                            var sDate = new Date(d_old[j].Value).toLocaleDateString("uk-Uk");
                            if (iCurrent.name().includes(sDate)) {
                                old_v = new Date(d_old[j].Value).toLocaleDateString("uk-Uk");
                                new_v = new Date(d_new[j].Value).toLocaleDateString("uk-Uk");
                                var nName = iCurrent.name().replace(old_v, new_v);
                                iCurrent.name(nName);
                            }
                        } catch {
                            var valField = d_old[j].Value;
                            if (iCurrent.name().includes(valField)) {
                                old_v = d_old[j].Value
                                new_v = new d_new[j].Value;
                                var nName = iCurrent.name().replace(old_v, new_v);
                                iCurrent.name(nName);
                            }
                        }

                    }
                }

                // Now update the value of the old cookie so it works multiple times. 11.09.2024 Janko Jovičić
                setCookie('old', getCookie("new"));


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

                                    }
                                })
                            }

                        }
                        var splited = window.item_caption.split("series__");
                        splited_removed = removeItemOnce(splited);
                        var f = window.item_caption.replace("__legend__series__", "")
                        return f;
                    }
                    chart.option("legend", legend);

                } else if (args.ItemName.startsWith("pieMap")) {
                    try {
                        var elms = document.getElementsByClassName("dxm-legend")
                        var texts = elms[0].getElementsByTagName("text")
                        for (var i = 0; i < texts.length; i++) {
                            var inner = texts[i];


                            var list = dashboard.GetParameters().GetParameterList();
                            if (list.length > 0) {

                                var parameterized_values = regex_return(inner.innerHTML);
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
                                            inner.innerHTML = inner.innerHTML.replace(text_to_replace, text_replace);

                                        }
                                    })
                                }

                            }
                        }

                    } catch (err) {

                    }

                }
            }

            function PerformDelete(dashboardid) {
                setCookie("temp", dashboardid, 365);
                $.ajax({
                    type: "POST",
                    url: 'Default.aspx/DeleteItem',
                    data: `{id: ${dashboardid}}`,
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (msg) {
                       // window.location.reload();
                    },
                    error: function (e) {
                        //window.location.reload();
                    }
                });
            }


            payload = [];

            var extension;
            var controlMain;
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
                dashboardControl.registerExtension(new DeleteDashboardExtension(sender));
                dashboardControl.unregisterExtension("designerToolbar");
                controlMain = dashboardControl;

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
                $(".dx-dashboard-surface").attr('style', 'left: 250px !important');
                changePicStateHideIt(true);

            }


            function hide() {

                $('.dx-overlay-content').hide();
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


    function onDashboardTitleToolbarUpdated(sender, e) {
                e.Options.actionItems.unshift({
                    type: "button",
                    icon: "dx-dashboard-clear-master-filter",
                    hint: "Clear all filters",
                    click: function (element) {
                        ClearMasterFilterState();
                    }
                });
            }  
            function ClearMasterFilterState() {

                var state = JSON.parse(dashboard.GetDashboardState());
                $.each(state.Items, function (index, element) {
                    var startState = JSON.parse(initialState);
                    debugger;
                    if (startState.Items[index]) {
                        element.MasterFilterValues = startState.Items[index].MasterFilterValues;
                    }
                    else
                        element.MasterFilterValues = [];
                });
                var newState = JSON.stringify(state);
                dashboard.SetDashboardState(newState);
            }
            var initialState = '';
    function onDashboardEndUpdate(s, e) {
                if (initialState == '') {
                    initialState = s.GetDashboardState();
                }
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
    <dx:ASPxDashboard ID="ASPxDashboard1" runat="server" OnCustomDataCallback="ASPxDashboard1_CustomDataCallback" AllowCreateNewJsonConnection="True"  ClientInstanceName="dashboard"  AllowExecutingCustomSql="True" AllowInspectAggregatedData="True"    MobileLayoutEnabled="Auto" AllowInspectRawData="True" DashboardStorageFolder="~/App_Data/Dashboards" EnableCustomSql="True" EnableTextBoxItemEditor="True" >
        <ClientSideEvents BeforeRender="onBeforeRender" 
             
			              ItemCaptionToolbarUpdated="onItemCaptionToolbarUpdated" 
                          ItemWidgetCreated="customizeWidgets"
                          DashboardTitleToolbarUpdated ="onDashboardTitleToolbarUpdated"
                          ItemWidgetUpdated="updatecustomizeWidgets"   
                          DashboardEndUpdate="onDashboardEndUpdate"
                          DashboardInitialized="correctTheLoadingState" 
                          
                              />
    </dx:ASPxDashboard>
</div>

   
</asp:Content>
