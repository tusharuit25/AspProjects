<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="index.aspx.cs" Inherits="NewEventManager.index" EnableEventValidation="false" %>

<!DOCTYPE html>
<html manifest="app.appcache" lang="en">
<head runat="server">
    <title id="title" runat="server">Event App</title>
    <link rel="stylesheet" href="http://code.jquery.com/mobile/1.3.1/jquery.mobile-1.3.1.css" />
    <script type="text/javascript" src="http://code.jquery.com/mobile/1.0a3/jquery.mobile-1.0a3.min.js"></script>
    <link rel="stylesheet" href="css/style.css" />
    <link rel="stylesheet" href="http://code.jquery.com/mobile/latest/jquery.mobile.css" />
    <link rel="stylesheet" href="css/jquery.mobile.fixedToolbar.polyfill.css" />
    <link rel="stylesheet" href="css/jqm-docs.css" />
    <script src="http://code.jquery.com/jquery-1.7.1.min.js"></script>
    <script src="http://code.jquery.com/mobile/latest/jquery.mobile.js"></script>
    <script src="js/jquery.mobile.fixedToolbar.polyfill.js"></script>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <meta name="DC.language" content="en" />
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
    <link rel="apple-touch-icon" sizes="57×57" href="images/icon_twitter@2x.png" />
    <link rel="apple-touch-startup-image" href="images/loading.gif" />
    <script src="js/widgets.js"></script>
    <script src="js/bubble.js"></script>
    <script src="js/iscroll.js"></script>
    <script src="http://js.pusher.com/1.12/pusher.min.js" type="text/javascript"></script>
    <link type="text/css" href="css/jquery.toastmessage.css" rel="stylesheet" />
    <script src="js/jquery.toastmessage.js"></script>
    <script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script>
    <link href="css/jquery.mobile.simpledialog.min.css" rel="stylesheet" />
    <script src="js/jquery.mobile.simpledialog2.min.js"></script>
    <script language="javascript" src="js/jquery.tweet.js" type="text/javascript"></script>
    <link href="css/jquery.tweet.css" media="all" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="http://maps.google.com/maps/api/js?v=3&sensor=false&language=en"></script>
    <style>
        .rounded-corners {
            -moz-border-radius: 10px;
            -webkit-border-radius: 10px;
            -khtml-border-radius: 10px;
            border: 1px solid #a7a7a7;
            padding: 10px;
            color: #fff;
            margin-top: 5px;
            background-color: #F7F7F7;
            min-height: 13px;
            text-decoration: none;
        }

        .containing-element .ui-slider-switch {
            width: 9em;
        }

        .listex {
            height: 92px;
        }

        .listex1 {
            height: 50px;
        }

        .ui-li-thumb {
            height: auto;
            width: auto;
        }
        .ExhiMapImag {
            height: 100%;
            width: 100%;
        }

        .ui-listview-filter .ui-input-search {
            margin: 25px;
            margin-bottom: 25px;
            width: auto;
            display: block;
        }


        .ui-listview-filter {
            border-width: 0;
            overflow: hidden;
            margin: -25px 0px -8px -11px;
        }

        .poll-box {
            background: none repeat scroll 0 0 #C3C4C7;
            margin-left: 0px;
            margin-top: 41px;
            padding: 10px;
            width: auto;
        }

        .poll-question {
            background: #000F00;
            color: White;
            border: solid 1px white;
            padding: 5px;
            margin-bottom: 10px;
        }

        .poll-total {
            background: #FFFFFF;
            color: Black;
            border: solid 1px black;
            padding: 5px;
            margin-bottom: 10px;
            text-align: center;
            text-transform: uppercase;
            font-size: 12px;
        }

        .poll-result {
            font-size: 12px;
            padding-left: 4px;
        }

        .poll-chart {
            background: #555555;
            padding: 4px;
            height: 15px;
            overflow: hidden;
            vertical-align: middle;
            margin-bottom: 10px;
        }

        .profile_image {
            border: 1px solid #000;
            width: auto;
            height: auto;
        }

        .footerNew {
            background: url(acecqa-banner.jpg) no-repeat;
            background-position: top;
            background-size: 100%;
        }
    </style>
    <script type="text/javascript">
        Pusher.log = function (message) {
            if (window.console && window.console.log) {
                window.console.log(message);
                updateManifestCheck();
            };

        };
        WEB_SOCKET_DEBUG = true;
        var pusher = new Pusher('5673b5c9bbc884c3d2c2');
        var channel = pusher.subscribe('my-channel');
        var pusher1 = new Pusher('5673b5c9bbc884c3d2c2');
        var channelPoll = pusher1.subscribe('my-pole');
        channelPoll.bind('my-question', function (data) {
            if (data.endmessage != null) {
                var tempecode = getSecondPart(data.endmessage)
                var message = data.endmessage;
                $('#sessionText').text("Session ended,Thank you for participating!");
                $().toastmessage('showToast', {
                    text: message,
                    sticky: true,
                    position: 'top-right',
                    type: 'warning',
                    closeText: '',
                    close: function () {
                        console.log("toast is closed ...");
                    }
                });
            }
            var count = 0;
            var _pollID, _PollChoiceID, _EventCode, _SessionID, _QuestionText, _EventName;
            var _Choice = new Array();
            var _PollChoiceID = new Array();
            for (var x in data) {
                if (count == 0) {
                    _pollID = data[x];
                }
                if (count == 1) {
                    _PollChoiceID = data[x];
                }
                if (count == 2) {
                    _EventCode = data[x];
                }
                if (count == 3) {
                    _EventName = data[x];
                }
                if (count == 4) {
                    _SessionID = data[x];
                }
                if (count == 5) {
                    _QuestionText = data[x];
                }
                if (count == 6) {
                    _Choice = data[x];
                }
                count++;
            }
            try {
                var selectedsession = $("#sessionPick").val();
                if (selectedsession == _SessionID) {

                    $('#lblEventCode').text("Event Code: " + _EventCode + " (" + _EventName + ")");
                    //$('#lblEventCode').text("Event Code: " + _EventName);
                    $('#lblquestion').text("Q: " + _QuestionText);
                    $('#hidPollID').val(_pollID);
                    $('#hideventcode').val(_EventCode);
                    $('#hidsessionid').val(_SessionID);
                    $('#livepollcontainer').show();
                    $('#divPoll').show();
                    $('#divAnswers').empty();
                    $('#sessionText').text("Session In Progress");
                    var htmltoadd = '<fieldset data-role="controlgroup" data-type="vertical" id="PollChoiceList">' +
                                       '<legend>Choose an option:</legend>';
                    for (var c = 0; c < _Choice.length; c++) {
                        htmltoadd = htmltoadd + '<input type="radio" name="rdoPoll" id="radoption1' + c + '" value="' + _PollChoiceID[c] + '" />';
                        htmltoadd = htmltoadd + '<label for="radoption1' + c + '" id="optionpolllabel' + c + '">' + _Choice[c] + '</label>';
                    }
                    htmltoadd = htmltoadd + '</fieldset>';
                    $('#divAnswers').append(htmltoadd).trigger('create');
                    $('#divAnswers').controlgroup("refresh")
                    $("#livepoll").page();
                }
            } catch (e) {
            }
        });
        channel.bind('my-event', function (data) {
            var tempecode = getSecondPart(data.message)
            if (tempecode.toString() === ecode.toString()) {
                var message = getFirstPart(data.message)
                $().toastmessage('showToast', {
                    text: message,
                    sticky: true,
                    position: 'top-right',
                    type: 'warning',
                    closeText: '',
                    close: function () {
                        console.log("toast is closed ...");
                    }
                });
            }
        });
        function getSecondPart(str) {
            return str.split(':')[1];
        }
        function getFirstPart(str) {
            return str.split(':')[0];
        }
    </script>
    <script type="text/javascript" language="javascript">
        $(function () {
            setTimeout(hideSplash, 3000);
        });
        function hideSplash() {
            var _lastvisitedPage = localStorage.getItem("lastvistedpage");
            if (_lastvisitedPage === null) {
                $.mobile.changePage("index.aspx#home", "fade");
            }
            else {
                $.mobile.changePage(_lastvisitedPage, "fade");
            }
        }
    </script>
    <script type="text/javascript">
        window.addEventListener('mousedown', function (e) {
            //alert("Swapping cache...");
            window.applicationCache.addEventListener('updateready', function (e) {
                if (window.applicationCache.status == window.applicationCache.UPDATEREADY) {
                    window.applicationCache.swapCache();
                    //if (confirm('App has been updated. \n Click OK to reload your App')) {
                    window.location.reload();
                    //}
                    alert("Swapping cache...");
                }
                if (window.applicationCache.status == window.applicationCache.IDLE) {
                    $().toastmessage('showToast', {
                        text: 'App is upto date ...',
                        sticky: false,
                        position: 'top-right',
                        type: 'success',
                        closeText: '',
                        close: function () {
                        }
                    });
                }
            }, false);
        }, false);
        function updateManifestCheck() {
            console.log("Checking for manifest change....");
            if (window.applicationCache.status == window.applicationCache.UPDATEREADY) {
                window.applicationCache.swapCache();
                //if (confirm('App has been updated. \n Click OK to reload your App')) {
                //window.location.reload();
                //}
                console.log("Change Found Manifest Swappin cache.......");
            }
        }
    </script>
    <script type="text/javascript" language="javascript">
        var db = null;
        var shortName = 'NewEventManager';
        var version = '1.0';
        var displayName = 'Event Manager';
        var maxSize = 65536;
        var ecode;
        var username;
        var password;
        var ucode;
        var AttendeeId;
        var file;
        var mobileDemo = { 'center': '0.0,0.0', 'zoom': 10 };
        var map, currentPosition, directionsDisplay, directionsService;
        var geocoder;
        ecode = localStorage.getItem("EventCode");
        ucode = localStorage.getItem("username");
        username = localStorage.getItem("username");
        password = localStorage.getItem("password");
        AttendeeId = localStorage.getItem("AttendeeId");
        var lastvisitedPage;
        try {
            db = openDatabase(shortName, version, displayName, maxSize);
            db.transaction(
                function (transaction) {
                    transaction.executeSql('CREATE TABLE IF NOT EXISTS tbl_Authentication(id INTEGER NOT  NULL PRIMARY KEY  ,username TEXT  NULL, password TEXT  NULL,eventcode TEXT  NULL,title TEXT  NULL,fname TEXT  NULL,lname TEXT  NULL,contactname TEXT  NULL)');
                    transaction.executeSql('CREATE TABLE IF NOT EXISTS tbl_Attendee(id INTEGER NOT  NULL,event_code TEXT  NULL,Attendee_Level INT,Title TEXT  NULL, Firstname TEXT  NULL, Lastname TEXT  NULL,Position TEXT  NULL,Category_Industry TEXT  NULL,Address TEXT  NULL,Phone_Number TEXT  NULL,Email TEXT  NULL,Biography TEXT,Website TEXT  NULL,company TEXT  NULL,MIMEtype TEXT  NULL,checkin TEXT  NULL,offlineUpdate TEXT NULL DEFAULT NO,facebook TEXT  NULL,twitter TEXT  NULL,linkedin TEXT  NULL,adminlink Text Null)');
                    transaction.executeSql('CREATE TABLE IF NOT EXISTS tbl_Exhibitor(id INTEGER NOT  NULL PRIMARY KEY ,event_code TEXT  NULL,company TEXT  NULL,standno INT, catagory TEXT  NULL, address TEXT  NULL,phoneno TEXT  NULL,email TEXT  NULL,biography TEXT  NULL,contactname TEXT  NULL,website TEXT  NULL, position TEXT  NULL,sponsorshiplevel INT,facebook TEXT  NULL,twitter TEXT  NULL,linkedin TEXT  NULL,MIMEtype TEXT  NULL,product1 TEXT  NULL,product2 TEXT  NULL,product3 TEXT  NULL,product4 TEXT  NULL,product5 TEXT  NULL,MAPMIMEType TEXT  NULL,adminlink Text Null)');
                    transaction.executeSql('CREATE TABLE IF NOT EXISTS tbl_Speaker(id INTEGER NOT  NULL PRIMARY KEY ,event_code TEXT  NULL,title TEXT, firstname TEXT  NULL, lastname TEXT  NULL,position TEXT  NULL,categoryIndustry TEXT  NULL,company TEXT  NULL,address TEXT  NULL,phoneno TEXT  NULL,email TEXT  NULL,website TEXT  NULL,biography TEXT  NULL,facebook TEXT  NULL,twitter TEXT  NULL,linkedin TEXT  NULL,MIMEtype TEXT  NULL,adminlink Text Null)');
                    transaction.executeSql('CREATE TABLE IF NOT EXISTS tbl_News(id INTEGER NOT  NULL PRIMARY KEY ,event_code TEXT  NULL,attaindeeLevel TEXT  NULL, authorName TEXT  NULL, newsdate TEXT  NULL,short TEXT  NULL,description TEXT  NULL,Newsid TEXT  NULL,title TEXT  NULL,newstime TEXT  NULL,MIMEtype TEXT  NULL,filename TEXT  NULL,fileextention TEXT  NULL,contenttype TEXT  NULL)');
                    transaction.executeSql('CREATE TABLE IF NOT EXISTS tbl_Session(id INTEGER NOT  NULL PRIMARY KEY ,event_code TEXT  NULL,sessionTitle TEXT, sessionDate TEXT  NULL, sessionStartTime TEXT  NULL,sessionFinishTime TEXT  NULL,sessionLocation TEXT  NULL,overview TEXT  NULL,sessionSpeakerFname TEXT  NULL)');
                    transaction.executeSql('CREATE TABLE IF NOT EXISTS tbl_Checkin(id INTEGER NOT  NULL PRIMARY KEY AUTOINCREMENT,event_code TEXT  NULL,user_code TEXT,logindatetime TEXT,flag TEXT)');
                    transaction.executeSql('CREATE TABLE IF NOT EXISTS tbl_Sponsor(id INTEGER NOT  NULL PRIMARY KEY ,event_code TEXT  NULL,sponsorname TEXT  NULL, discription TEXT  NULL,MIMEtype TEXT  NULL,product1 TEXT  NULL, product2 TEXT  NULL, product3 TEXT  NULL, product4 TEXT  NULL, product5 TEXT  NULL, facebook TEXT  NULL, youtube TEXT  NULL, twitter TEXT  NULL,contactname TEXT  NULL,phone TEXT  NULL,email TEXT  NULL,position TEXT null,address TEXT null,adminlink Text Null,website text null) ');
                    transaction.executeSql('CREATE TABLE IF NOT EXISTS tbl_twitter(id INTEGER NOT  NULL PRIMARY KEY ,event_code TEXT  NULL,tlink TEXT  NULL,twitterid TEXT  NULL)');
                    transaction.executeSql('CREATE TABLE IF NOT EXISTS tbl_Event(event_code TEXT NOT  NULL PRIMARY KEY ,company_name TEXT  NULL, user_req_id TEXT  NULL,usercontact TEXT  NULL,useremail TEXT  NULL,eventreqDate TEXT  NULL,eventname TEXT  NULL,eventtype TEXT  NULL,eventlevel TEXT  NULL,evestartdate TEXT  NULL,eveenddate TEXT  NULL,evestarttime TEXT  NULL,evefinishtime TEXT  NULL,timeZone TEXT  NULL,MIMEtype TEXT  NULL,MIMEtype1 TEXT  NULL,MIMEtype2 TEXT  NULL,MIMEtype3 TEXT  NULL,MIMEtype4 TEXT  NULL,mapkey TEXT  NULL,latitude TEXT  NULL,longitude TEXT NULL)');
                    transaction.executeSql('CREATE TABLE IF NOT EXISTS tbl_SessionNote(id INTEGER NOT  NULL PRIMARY KEY AUTOINCREMENT,ucode TEXT  NULL, sessionid int  NULL,note text null)');
                    transaction.executeSql('CREATE TABLE IF NOT EXISTS tbl_QuestionsEvent(id INTEGER NOT  NULL PRIMARY KEY ,event_code TEXT NOT  NULL,questionText TEXT  NULL,flag bool null default false)');
                    transaction.executeSql('CREATE TABLE IF NOT EXISTS tbl_QuestionAnswers(id INTEGER NOT  NULL PRIMARY KEY AUTOINCREMENT,event_code TEXT NOT  NULL,questionId int NULL, attendeeid int  NULL,optionid int null)');
                    transaction.executeSql('CREATE TABLE IF NOT EXISTS tbl_FavoriteAttendee(id INTEGER NOT  NULL PRIMARY KEY AUTOINCREMENT,ucode int  NULL, attendeeid int  NULL,flag bool null default false)');
                    transaction.executeSql('CREATE TABLE IF NOT EXISTS tbl_FavoriteExihibitor(id INTEGER NOT  NULL PRIMARY KEY AUTOINCREMENT,ucode int  NULL, exhiid int  NULL,flag bool null default false)');
                    transaction.executeSql('CREATE TABLE IF NOT EXISTS tbl_FavoriteSpeaker(id INTEGER NOT  NULL PRIMARY KEY AUTOINCREMENT,ucode int  NULL, speakerid int  NULL,flag bool null default false)');
                    transaction.executeSql('CREATE TABLE IF NOT EXISTS tbl_FavoriteSession(id INTEGER NOT  NULL PRIMARY KEY AUTOINCREMENT,ucode int  NULL, sessionid int  NULL,flag bool null default false)');
                    transaction.executeSql('CREATE TABLE IF NOT EXISTS tbl_Message(id INTEGER NOT  NULL PRIMARY KEY ,fromid int  NULL, toid int  NULL,messsagetext text null,fromname text null,toname text null,messagedate text null,flag bool null default false,sendertype int null)');
                    transaction.executeSql('CREATE TABLE IF NOT EXISTS tbl_SpeakerToSession(id INTEGER NOT  NULL PRIMARY KEY ,speakerid int  NULL, sessionid int  NULL)');
                    transaction.executeSql('CREATE TABLE IF NOT EXISTS tbl_Notification(id INTEGER NOT  NULL PRIMARY KEY ,message text  NULL, notificationdate text  NULL)');
                    transaction.executeSql('CREATE TABLE IF NOT EXISTS tbl_SubEvent(id INTEGER NOT  NULL PRIMARY KEY AUTOINCREMENT,event_code text  NULL, eventname text  NULL)');

                }
             );

            if (!navigator.onLine) {
                db = openDatabase(shortName, version, displayName, maxSize);
                db.transaction(function (transaction) {
                    transaction.executeSql('SELECT * FROM tbl_Authentication', [], function (transaction, results) {
                        if (results.rows.length != 0) {
                            var st_username = results.rows.item(0).username;
                            var st_password = results.rows.item(0).password;
                            if (st_username == username && st_password == password) {
                                $("#txtecode").val("");
                                $("#txtucode").val("");
                                lastvisitedPage = localStorage.getItem("lastvistedpage");
                                $.mobile.changePage(lastvisitedPage);
                                if (navigator.onLine) {
                                    loadNotifications(); // showing notifications
                                }
                            }
                            else {
                                $("#txtecode").val("");
                                $("#txtucode").val("");
                                $.mobile.changePage("#home");
                                if (navigator.onLine) {
                                    loadNotifications(); // showing notifications
                                }
                            }
                        }
                        else {
                            $.mobile.changePage("#home");
                        }
                    });
                });
            }
        } catch (e) {
        }
        $(document).ready(function () {
            $("#btnSubmitVote").click(function () {
                sendVoteResult();
            });
            $("#btnlogin").click(function () {
                getLogin();
            });
            $("#btnprofileSaveNew").click(function () {
                //saveOffline();
                $().toastmessage('showToast', {
                    text: 'Profile Information Saved ...',
                    sticky: false,
                    position: 'top-right',
                    type: 'success',
                    closeText: '',
                    close: function () {
                    }
                });
            });
            $("#btnSpeakerFavNew").click(function () {
                setSpeakerFavorite();
                $().toastmessage('showToast', {
                    text: 'Speaker Added To Your favorite list ...',
                    sticky: false,
                    position: 'top-right',
                    type: 'success',
                    closeText: '',
                    close: function () {
                    }
                });
            });
            $("#btnSpeakerConnect").click(function () {
                connectToSpeaker();
            });
            $("#btnAttendeeFaveNew").click(function () {
                setAttendeeFavorite();
                $().toastmessage('showToast', {
                    text: 'Attendee Added To Your favorite list ...',
                    sticky: false,
                    position: 'top-right',
                    type: 'success',
                    closeText: '',
                    close: function () {
                    }
                });
            });
            $("#btnAttendeeConnectNew").click(function () {
                connectToAttendee();
            });
            $("#btnExhibitorFavsaveNew").click(function () {
                setExhibitorFavorite();
                $().toastmessage('showToast', {
                    text: 'Exhibitor Added To Your favorite list ...',
                    sticky: false,
                    position: 'top-right',
                    type: 'success',
                    closeText: '',
                    close: function () {
                    }
                });
            });
            $("#btnExhibitorConnect").click(function () {
                connectToExhibitor();
            });

            $("#sponsorconnectbutton").click(function () {
                connectToSponsor();
            });
            $("#btnSessionFavsaveNew").click(function () {
                setSessionFavorite();
                $().toastmessage('showToast', {
                    text: 'Session Added To Your favorite list ...',
                    sticky: false,
                    position: 'top-right',
                    type: 'success',
                    closeText: '',
                    close: function () {
                    }
                });
            });
            $("#btnSessionNote").click(function () {
                connectToExhibitor();
            });
            $("#btnSpeakerUnFavNew").click(function () {
                unsetSpeakerFavorite();
                $().toastmessage('showToast', {
                    text: 'Speaker Removed from Your favorite list ...',
                    sticky: false,
                    position: 'top-right',
                    type: 'success',
                    closeText: '',
                    close: function () {
                    }
                });
            });
            $("#btnExhibitorUnFavsaveNew").click(function () {
                unsetExhibitorFavorite();
                $().toastmessage('showToast', {
                    text: 'Exhibitor Removed from Your favorite list ...',
                    sticky: false,
                    position: 'top-right',
                    type: 'success',
                    closeText: '',
                    close: function () {
                    }
                });
            });

            $("#btnAttendeeUnfavNew").click(function () {
                unsetAttendeeFavorite();
                $().toastmessage('showToast', {
                    text: 'Attendee Removed from Your favorite list ...',
                    sticky: false,
                    position: 'top-right',
                    type: 'success',
                    closeText: '',
                    close: function () {
                    }
                });
            });
            $("#btnSessionUnFavsaveNew").click(function () {
                unsetSessionFavorite();
                $().toastmessage('showToast', {
                    text: 'Session Removed from Your favorite list ...',
                    sticky: false,
                    position: 'top-right',
                    type: 'success',
                    closeText: '',
                    close: function () {
                    }
                });
            });

            $("#btnSessionNote").click(function () {
                saveSessionNote();
                $().toastmessage('showToast', {
                    text: 'Session Note saved successfully ...',
                    sticky: false,
                    position: 'top-right',
                    type: 'success',
                    closeText: '',
                    close: function () {
                    }
                });
            });
            $("#otherbuttonid").click(function () {
                var ID = $('#eevalquestionid').val();
                showOther(ID);
            });
            $("#btnSubmitAnsEEval").click(function () {
                var ID;
                $("input[name*=radio-view]:checked").each(function () {
                    ID = $(this).val();
                });
                var ID = $('#eevalquestionid').val();
                saveEventEval(ID);
            });

            $("#btnSync").click(function () {
                getChoiceEventLoaded();
            });
        });

        function loadNotifications() {
            db = openDatabase(shortName, version, displayName, maxSize);
            db.transaction(function (transaction) {
                transaction.executeSql('SELECT * FROM tbl_Notification', [], function (transaction, results) {
                    if (results.rows.length != 0) {
                        for (var i = 0; i < length; i++) {
                            $().toastmessage('showToast', {
                                text: results.rows.item(i).message.toString() + ' ' + results.rows.item(i).notificationdate,
                                sticky: false,
                                position: 'top-right',
                                type: 'success',
                                closeText: '',
                                close: function () {
                                }
                            });
                        }


                    }
                });
            });
        }
        function getChoiceEventLoaded() {
            if (navigator.onLine) {
                PageMethods.getSubscribedEvents(AttendeeId, onSucess, onError);
                function onSucess(result) {
                    if (result.length > 0) {
                        var tempdb = db;
                        tempdb.transaction(
                            function (transaction) {
                                transaction.executeSql('Delete from tbl_SubEvent');
                                ProcessSubscribedEvents(result);
                            }
                         );
                    }
                }
                function onError(result) {
                }
            }
        }
        function ProcessSubscribedEvents(result) {
            try {
                for (var i = 0 ; i < result.length; i++) {
                    var _eventcode = result[i]["EventCode"].toString();
                    var _eventname = result[i]["EventName"].toString();
                    InsertSubscribedEventsToWebSql(_eventcode, _eventname);
                }
            }
            catch (e) {
            }
        }

        function InsertSubscribedEventsToWebSql(_eventcode, _eventname) {
            try {
                db = openDatabase(shortName, version, displayName, maxSize);
                db.transaction(
                    function (transaction) {
                        transaction.executeSql('INSERT INTO tbl_SubEvent(event_code,eventname) values(?,?)',
                            [_eventcode.toString(), _eventname.toString()]);
                    });
            } catch (e) {
            }
        }
        function sendVoteResult() {
            $("#divPoll").css("cursor", "wait");
            var pID = $("input[id$=hidPollID]").val();
            var cID = $("input[name='rdoPoll']:checked").val();
            var eventcode = $("input[id$=hideventcode]").val();
            var sessionid = $("input[id$=hidsessionid]").val();
            if (navigator.onLine) {
                PageMethods.UpdatePollCount(pID, cID, eventcode, sessionid, onSucess, onError);
                function onSucess(result) {
                    $("#divPoll").css("cursor", "default");
                    $('#divAnswers').empty();
                    $('#livepollcontainer').hide();
                    $('#divPoll').hide();
                    $('#sessionText').text("Session In Progress: Thanks For Your Vote...!");
                }
                function onError(result) {
                }
            }
        }

        function saveSessionNote() {
            var ID = $('#sessionhiddenid').val();
            submitNote(ID);
        }
        function unsetSessionFavorite() {
            var ID = $('#sessionhiddenidfav').val();
            setUnsetFavoriteSession(ID);
        }
        function unsetAttendeeFavorite() {
            var ID = $('#AttendeeHiddenIdFav').val();
            setUnsetFavorite(ID);
        }
        function unsetExhibitorFavorite() {
            var ID = $('#exhibitorhiddenidFav').val();
            setUnsetFavoriteExhibitor(ID);
        }
        function unsetSpeakerFavorite() {
            var ID = $('#speakerhiddenidFav').val();
            setUnsetFavoriteSpeaker(ID);
        }
        function setExhibitorFavorite() {
            var ID = $('#exhibitorhiddenid').val();
            setUnsetFavoriteExhibitor(ID);
        }
        function connectToExhibitor() {
            var ID = $('#exhibitorhiddenid').val();
        }
        function connectToSponsor() {
            var ID = $('#sponsorhiddenid').val();
        }
        function setSpeakerFavorite() {
            var ID = $('#speakerhiddenid').val();
            setUnsetFavoriteSpeaker(ID);
        }
        function connectToSpeaker() {
            var ID = $('#speakerhiddenid').val();
        }
        function setAttendeeFavorite() {
            var ID = $('#AttendeeHiddenId').val();
            setUnsetFavorite(ID);
        }
        function connectToAttendee() {
            var ID = $('#AttendeeHiddenId').val();
        }

        function setSessionFavorite() {
            var ID = $('#sessionhiddenid').val();
            setUnsetFavoriteSession(ID);
        }
        function connectToSession() {
            var ID = $('#sessionhiddenid').val();
        }
        function setUnsetFavoriteSession(id) {
            db = openDatabase(shortName, version, displayName, maxSize);
            ucode = localStorage.getItem("AttendeeId");
            db.transaction(
            function (transaction) {
                transaction.executeSql('SELECT flag FROM tbl_FavoriteSession where ucode=? and sessionid=?', [ucode, id], function (transaction, results) {
                    try {
                        var flag = results.rows.item(0).flag;
                        if (flag.toString() == "true") {
                            callUnsetSession(id);
                        }
                        else if (flag.toString() == "false") {
                            callUnsetupdateSession(id);
                        }
                    } catch (e) {
                        callsetSession(id);
                    }
                });
            });
        }
        function callUnsetSession(id) {
            ucode = localStorage.getItem("AttendeeId");
            db = openDatabase(shortName, version, displayName, maxSize);
            db.transaction(
                function (transaction) {
                    transaction.executeSql('update tbl_FavoriteSession set flag="false" where ucode=? and sessionid=?', [ucode, id], function (transaction, results) {
                    });
                }
             );
        }
        function callUnsetupdateSession(id) {
            ucode = localStorage.getItem("AttendeeId");
            db = openDatabase(shortName, version, displayName, maxSize);
            db.transaction(
                function (transaction) {
                    transaction.executeSql('update tbl_FavoriteSession set flag="true" where ucode=? and sessionid=?', [ucode, id], function (transaction, results) {
                    });
                }
             );

        }
        function callsetSession(id) {
            ucode = localStorage.getItem("AttendeeId");
            db = openDatabase(shortName, version, displayName, maxSize);
            db.transaction(
                function (transaction) {
                    transaction.executeSql('insert into tbl_FavoriteSession(ucode,sessionid,flag) values(?,?,"true")', [ucode, id], function (transaction, results) {
                    });
                }
             );
        }
        function setUnsetFavoriteExhibitor(id) {
            try {
                ucode = localStorage.getItem("AttendeeId");
                db = openDatabase(shortName, version, displayName, maxSize);
                db.transaction(
                    function (transaction) {

                        transaction.executeSql('SELECT flag FROM tbl_FavoriteExihibitor where ucode=? and exhiid=?', [ucode, id], function (transaction, results) {
                            try {
                                var flag = results.rows.item(0).flag;
                                if (flag.toString() === "true") {
                                    callUnsetexhi(id);
                                }
                                else if (flag.toString() === "false") {
                                    callUnsetupdateexhi(id);
                                }
                            }
                            catch (e) {
                                callsetexhi(id);
                            }
                        });
                    }
                 );
            } catch (e) {
            }
        }
        function callUnsetexhi(id) {
            try {
                ucode = localStorage.getItem("AttendeeId");
                db = openDatabase(shortName, version, displayName, maxSize);
                db.transaction(
                    function (transaction) {
                        transaction.executeSql('update tbl_FavoriteExihibitor set flag="false" where ucode=? and exhiid=?', [ucode, id], function (transaction, results) {
                        });
                    }
                 );

            } catch (e) {
            }
        }
        function callUnsetupdateexhi(id) {
            try {
                ucode = localStorage.getItem("AttendeeId");
                db = openDatabase(shortName, version, displayName, maxSize);
                db.transaction(
                    function (transaction) {
                        transaction.executeSql('update tbl_FavoriteExihibitor set flag="true" where ucode=? and exhiid=?', [ucode, id], function (transaction, results) {
                        });
                    }
                 );
            } catch (e) {
            }
        }
        function callsetexhi(id) {
            try {
                ucode = localStorage.getItem("AttendeeId");
                db = openDatabase(shortName, version, displayName, maxSize);
                db.transaction(
                    function (transaction) {
                        transaction.executeSql('insert into tbl_FavoriteExihibitor(ucode,exhiid,flag) values(?,?,"true")', [ucode, id], function (transaction, results) {
                        });
                    }
                 );
            } catch (e) {
            }
        }

        function setUnsetFavoriteSpeaker(ID) {
            ucode = localStorage.getItem("AttendeeId");
            db = openDatabase(shortName, version, displayName, maxSize);
            db.transaction(
                function (transaction) {
                    transaction.executeSql('SELECT flag FROM tbl_FavoriteSpeaker where ucode=? and speakerid=?', [ucode, ID], function (transaction, results) {
                        try {
                            var flag = results.rows.item(0).flag;
                            if (flag.toString() === "true") {
                                callUnsetSpeaker(ID);
                            }
                            else if (flag.toString() === "false") {
                                callUnsetupdateSpeaker(ID);
                            }
                            else if (flag.toString() === "Undefined") {
                                callsetSpeaker(ID);
                            }
                        } catch (e) { callsetSpeaker(ID); }

                    });
                });
        }
        function callUnsetSpeaker(id) {
            ucode = localStorage.getItem("AttendeeId");
            db = openDatabase(shortName, version, displayName, maxSize);
            db.transaction(
                function (transaction) {
                    transaction.executeSql('update tbl_FavoriteSpeaker set flag="false" where ucode=? and speakerid=?', [ucode, id], function (transaction, results) {
                    });
                }
             );
        }
        function callUnsetupdateSpeaker(id) {
            ucode = localStorage.getItem("AttendeeId");
            db = openDatabase(shortName, version, displayName, maxSize);
            db.transaction(
                function (transaction) {
                    transaction.executeSql('update tbl_FavoriteSpeaker set flag="true" where ucode=? and speakerid=?', [ucode, id], function (transaction, results) {
                    });
                }
             );
        }
        function callsetSpeaker(id) {
            ucode = localStorage.getItem("AttendeeId");
            db = openDatabase(shortName, version, displayName, maxSize);
            db.transaction(
                function (transaction) {
                    transaction.executeSql('insert into tbl_FavoriteSpeaker(ucode,speakerid,flag) values(?,?,"true")', [ucode, id], function (transaction, results) {
                    });
                }
             );
        }
        function getLogin() {
            try {
                username = $('#txtecode').val();
                password = $('#txtucode').val();
                localStorage.setItem("username", username);
                localStorage.setItem("password", password);
                if (ecode != "" || ucode != "") {

                    if (navigator.onLine) {
                        PageMethods.CheckAutheticationOnline(username, password, onSucess, onError);
                        function onSucess(result) {
                            if (result.length > 0) {
                                ProcessAuthentication(result)
                                getBackGroundRefresh();
                                $("#txtecode").val("");
                                $("#txtucode").val("");
                                $.mobile.changePage('#cpanel')
                            }
                            else {
                                $("#txtecode").val("");
                                $("#txtucode").val("");
                                $.mobile.changePage('#loginFail')
                            }
                        }
                        function onError(result) {
                            $("#txtecode").val("");
                            $("#txtucode").val("");
                        }
                    }
                    else {
                        db = openDatabase(shortName, version, displayName, maxSize);
                        db.transaction(
                            function (transaction) {
                                transaction.executeSql('SELECT * FROM tbl_Authentication', [], function (transaction, results) {

                                    var st_username = results.rows.item(0).username;
                                    var st_password = results.rows.item(0).password;
                                    if (st_username === username && st_password === password) {
                                        $("#txtecode").val("");
                                        $("#txtucode").val("");
                                        $.mobile.changePage('#cpanel')
                                        return true;
                                    }
                                    else {
                                        $("#txtecode").val("");
                                        $("#txtucode").val("");
                                        $.mobile.changePage('#loginFail')
                                        return false;
                                    }
                                });
                            }
                         );
                    }
                }
            }
            catch (e) {
            }
        }
        function ProcessAuthentication(result) {
            try {
                for (var i = 0 ; i < result.length; i++) {

                    var _id = result[i]["ID"].toString();
                    var _username = result[i]["Username"].toString();
                    var _password = result[i]["Password"].toString();
                    var _eventcode = result[i]["EventCode"].toString();
                    var _title = result[i]["Title"].toString();
                    var _fname = result[i]["FirstName"].toString();
                    var _lname = result[i]["LastName"].toString();
                    var _contactname = result[i]["ContactName"].toString();
                    var _usertype = result[i]["UserType"].toString();
                    var _name = _title + ' ' + _fname + ' ' + _lname;
                    console.log(_contactname.length);
                    console.log(_name.length);
                    if (_contactname.length > 0)
                        localStorage.setItem("SenderName", _contactname);
                    if (_name.length > 2)
                        localStorage.setItem("SenderName", _name);
                    AttendeeId = _id;
                    localStorage.setItem("AttendeeId", _id);
                    localStorage.setItem("EventCode", _eventcode);
                    localStorage.setItem("UserType", _usertype);
                    InsertAuthenticationToWebSql(_id, _username, _password, _eventcode, _title, _fname, _lname, _contactname);
                }
            }
            catch (e) {
            }
        }
        function InsertAuthenticationToWebSql(_id, _username, _password, _eventcode, _title, _fname, _lname, _contactname) {
            try {
                db = openDatabase(shortName, version, displayName, maxSize);
                db.transaction(function (transaction) {
                    transaction.executeSql('INSERT INTO tbl_Authentication(id,username,password,eventcode,title,fname,lname,contactname) values(?,?,?,?,?,?,?,?)',
                                [_id.toString(), _username.toString(), _password.toString(), _eventcode.toString(), _title.toString(), _fname.toString(), _lname.toString(), _contactname.toString()]);
                });
            } catch (e) {
            }
        }
        function getAttendeeLoaded() {
            if (navigator.onLine) {
                var ecode = localStorage.getItem("AttendeeId");
                PageMethods.GetAttaindeeData(ecode, onSucess, onError);
                function onSucess(result) {
                    var tempdb = db;
                    tempdb.transaction(
                        function (transaction) {
                            transaction.executeSql('Delete from tbl_Attendee');
                            ProcessAttaindee(result);
                        }
                     );
                }
                function onError(result) {
                }
            }

        }
        function ProcessAttaindee(result) {
            try {
                for (var i = 0 ; i < result.length; i++) {
                    var _id = result[i]["ID"].toString();
                    var _attendeeLevel = result[i]["AttendeeLevel"].toString();
                    var _eventcode = result[i]["EventCode"].toString();
                    var _Title = result[i]["Title"].toString();
                    var _FirstName = result[i]["FirstName"].toString();
                    var _LastName = result[i]["LastName"].toString();
                    var _Company = result[i]["Company"].toString();
                    var _Position = result[i]["Position"].toString();
                    var _Category = result[i]["Category"].toString();
                    var _Address = result[i]["Address"].toString();
                    var _PhoneNo = result[i]["PhoneNo"].toString();
                    var _Email = result[i]["Email"].toString();
                    var _Biography = result[i]["Biography"].toString();
                    var _Website = result[i]["Website"].toString();
                    var _MIMEtype = result[i]["MIMEType"].toString();
                    var _facebook = result[i]["Facebook"].toString();
                    var _twitter = result[i]["Twitter"].toString();
                    var _linkedin = result[i]["LinkedIn"].toString();
                    var _checkin = result[i]["Checkin"].toString();
                    var _adminlink = result[i]["AdminLink"].toString();
                    InsertAttainDeeToWebSql(_id, _attendeeLevel, _eventcode, _Title, _FirstName, _LastName, _Company, _Position, _Category, _Address, _PhoneNo, _Email, _Biography, _Website, _MIMEtype, _facebook, _twitter, _linkedin, _checkin, _adminlink);
                }
                $().toastmessage('showToast', {
                    text: 'App Updated Successfully ...',
                    sticky: false,
                    position: 'top-right',
                    type: 'success',
                    closeText: '',
                    close: function () {
                    }
                });
            } catch (e) {
            }
        }
        function InsertAttainDeeToWebSql(_id, _attendeeLevel, _eventcode, _Title, _FirstName, _LastName, _Company, _Position, _Category, _Address, _PhoneNo, _Email, _Biography, _Website, _MIMEtype, _facebook, _twitter, _linkedin, _checkin, _adminlink) {
            try {
                var tempdb = openDatabase(shortName, version, displayName, maxSize);
                tempdb.transaction(
                  function (transaction) {
                      transaction.executeSql('INSERT INTO tbl_Attendee(id,Attendee_Level,event_code,Title,Firstname,Lastname,Position,Category_Industry,Address,Phone_Number,Email,Biography,Website,company,MIMEtype,facebook, twitter, linkedin,checkin,adminlink) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)',
                             [parseInt(_id), parseInt(_attendeeLevel), _eventcode.toString(), _Title.toString(), _FirstName.toString(), _LastName.toString(), _Position.toString(), _Category.toString(), _Address.toString(), _PhoneNo.toString(), _Email.toString(), _Biography.toString(), _Website.toString(), _Company.toString(), _MIMEtype.toString(), _facebook.toString(), _twitter.toString(), _linkedin.toString(), _checkin.toString(), _adminlink.toString()]);
                  });
            } catch (e) {

            }
        }
        function getAttendee() {
            try {

                ecode = localStorage.getItem("EventCode");
                console.log("Currently Event Code is : " + ecode);
                db = openDatabase(shortName, version, displayName, maxSize);
                db.transaction(
                    function (transaction) {
                        transaction.executeSql('select tbl_Attendee.id,tbl_Attendee.event_code,tbl_Attendee.Attendee_Level,tbl_Attendee.Title, tbl_Attendee.Firstname, tbl_Attendee.Lastname,tbl_Attendee.Position,tbl_Attendee.Category_Industry,tbl_Attendee.Address,tbl_Attendee.Phone_Number,tbl_Attendee.Email,tbl_Attendee.Biography,tbl_Attendee.Website,tbl_Attendee.company,tbl_Attendee.MIMEtype,tbl_Attendee.checkin,tbl_Attendee.offlineUpdate,tbl_FavoriteAttendee.ucode, tbl_FavoriteAttendee.attendeeid,tbl_FavoriteAttendee.flag from tbl_Attendee left outer join tbl_FavoriteAttendee on tbl_Attendee.id = tbl_FavoriteAttendee.attendeeid where tbl_Attendee.event_code=?', [ecode], function (transaction, results) {
                            if (results.rows.length === 0) {
                                $('#attendeeList').empty();
                            }
                            else {
                                $('#attendeeList').empty();
                                for (i = 0; i < results.rows.length; i++) {
                                    renderTodo(results.rows.item(i));
                                }
                            }
                        });
                    }
                 );

            } catch (e) {
            }
        }
        function renderTodo(row) {
            try {
                var ID, MIMEtype, Firstname, Lastname, Flag;
                if (row.id === null || row.id === "" || row.id === "Undefined")
                { ID = ""; }
                else
                { ID = row.id }
                if (row.MIMEtype === null || row.MIMEtype === "" || row.MIMEtype === "Undefined")
                { MIMEtype = ""; }
                else
                { MIMEtype = row.MIMEtype; }
                if (row.Title === null || row.Title === "" || row.Title === "Undefined")
                { Title = ""; }
                else
                { Title = row.Title }
                if (row.Firstname === null || row.Firstname === "" || row.Firstname === "Undefined")
                { Firstname = ""; }
                else
                { Firstname = row.Firstname }
                if (row.Lastname === null || row.Lastname === "" || row.Lastname === "Undefined")
                { Lastname = ""; }
                else
                { Lastname = row.Lastname }
                if (row.Position === null || row.Position === "" || row.Position === "Undefined")
                { Position = ""; }
                else
                { Position = row.Position }
                if (row.company === null || row.company === "" || row.company === "Undefined")
                { Company = ""; }
                else
                { Company = row.company }
                if (row.flag === null || row.flag === "" || row.flag === "Undefined" || row.flag === "false")
                { Flag = ""; }
                else
                { Flag = row.flag }
                if (Flag === "") {
                    $('#attendeeList').append(
                          '<li class="listex">' +
                                '<a href="#AttendeeDetails"   onclick="getClick(' + ID + ');"><img src="imagesattaindee/' + ID + MIMEtype + '" class="ui-li-thumb" border="0" />' +
                                    '<h3 class="ui-li-heading">' + Firstname + ' ' + Lastname + '</h3>' +
                                    '<p class="ui-li-desc">' + Position + '</p>' +
                                    '<p class="ui-li-desc">' + Company + '</p></a>' +
                           '</li>'
                     );
                }
                else {
                    $('#attendeeList').append(
                       '<li class="listex">' +
                             '<a href="#AttendeeDetails"   onclick="getClick(' + ID + ');"><img src="imagesattaindee/' + ID + MIMEtype + '" class="ui-li-thumb" border="0" />' +
                                   '<h3 class="ui-li-heading">' + Firstname + ' ' + Lastname + '</h3>' +
                                    '<p class="ui-li-desc">' + Position + '</p>' +
                                    '<p class="ui-li-desc">' + Company + '</p>' +
                                 '<span class="ui-li-count" style="border:0px; font-size:18px"><a href="#" style="padding:0px; margin:0px; border:0px; background:round" data-role="button" data-icon="star" data-iconpos="notext">star</a></span></span>' +
                             '</a> ' +
                      '</li>'
                      );
                }
                $('#attendeeList').listview('refresh');
            }
            catch (e) {
            }

        }
        function getClick(ID) {
            db = openDatabase(shortName, version, displayName, maxSize);
            db.transaction(
                function (transaction) {
                    transaction.executeSql('select tbl_Attendee.id,tbl_Attendee.facebook,tbl_Attendee.twitter,tbl_Attendee.linkedin,tbl_Attendee.event_code,tbl_Attendee.Attendee_Level,tbl_Attendee.Title, tbl_Attendee.Firstname, tbl_Attendee.Lastname,tbl_Attendee.Position,tbl_Attendee.Category_Industry,tbl_Attendee.Address,tbl_Attendee.Phone_Number,tbl_Attendee.Email,tbl_Attendee.Biography,tbl_Attendee.Website,tbl_Attendee.company,tbl_Attendee.MIMEtype,tbl_Attendee.checkin,tbl_Attendee.offlineUpdate from tbl_Attendee where  tbl_Attendee.id = ?', [ID], function (transaction, results) {
                        if (results.rows.length === 0) {
                            $('#attendeeList').empty();
                        }
                        else {
                            $('#attendeeList').empty();
                            for (i = 0; i < results.rows.length; i++) {
                                renderTodo(results.rows.item(0));
                                document.getElementById('AttendeeImage').src = 'imagesattaindee/' + results.rows.item(0).id + results.rows.item(0).MIMEtype;
                                var name = results.rows.item(0).Title + " " + results.rows.item(0).Firstname + " " + results.rows.item(0).Lastname;
                                localStorage.setItem("AttendeeDetailId", ID);
                                $('#AttendeeHiddenId').val(ID);
                                $('#Attendeename').val(name);
                                $('#senderType1').val(1);
                                $('#toAttendeeId').val(ID);
                                localStorage.setItem("ReceiverName", name);
                                $('#AttendeeCompany').val(results.rows.item(0).company);
                                $('#txtCategory').val(results.rows.item(0).Category_Industry);
                                $('#txtBioGrapghy').val(results.rows.item(0).Biography);
                                $('#AttendeePosition').val(results.rows.item(0).Position);
                                $('#AttendeetxtEmail').val(results.rows.item(0).Email);
                                //$('#AttendeetxtPhoneno').val(results.rows.item(0).Phone_Number);
                                $('#AttendeetxtAddress').val(results.rows.item(0).Address);
                                $('#messageToAttendeeHead').html('Message to <br />' + name);
                                var aTag = document.getElementById('fblinkAttendee');
                                aTag.setAttribute('href', "http://" + results.rows.item(0).facebook.toString());
                                var aTag1 = document.getElementById('twitterlinkAttendee');
                                aTag1.setAttribute('href', "http://" + results.rows.item(0).twitter.toString());
                                var aTag2 = document.getElementById('linkedinlinkAttendee');
                                aTag2.setAttribute('href', "http://" + results.rows.item(0).linkedin.toString());

                                
                                var node2 = document.getElementById("callAttendee");
                                if (results.rows.item(0).Phone_Number === null || results.rows.item(0).Phone_Number === "" || results.rows.item(0).Phone_Number === "Undefined" || results.rows.item(0).Phone_Number === "false")
                                    node2.innerHTML = "<div Class='rounded-corners'> <a href='# > - </a> </div></br>";
                                else
                                    node2.innerHTML = "<div Class='rounded-corners'> <a href='tel:" + results.rows.item(0).Phone_Number + "'  data-role='button' data-icon='tel'>" + results.rows.item(0).Phone_Number + "</a> </div></br>";


                                var node = document.getElementById("AttendeeWeblink1");
                                if (results.rows.item(0).Website === null || results.rows.item(0).Website === "" || results.rows.item(0).Website === "Undefined" || results.rows.item(0).Website === "false")
                                    node.innerHTML = "<div Class='rounded-corners'> <a href='# > - </a> </div></br>";
                                else
                                    node.innerHTML = "<div Class='rounded-corners'> <a href='http://" + results.rows.item(0).Website + "' target='_blank' >" + results.rows.item(0).Website + "</a> </div></br>";
                            }
                        }
                    });
                }
             );
        }
        function showDialog(url) {
            $("#targetDiv").load(url);
            $("#targetDiv").dialog("open");
        }
        function setUnsetFavorite(id) {
            try {
                ucode = localStorage.getItem("AttendeeId");
                db = openDatabase(shortName, version, displayName, maxSize);
                db.transaction(
                    function (transaction) {
                        transaction.executeSql('SELECT flag FROM tbl_FavoriteAttendee where ucode=? and attendeeid=?', [ucode, id], function (transaction, results) {
                            try {
                                var flag = results.rows.item(0).flag;
                                if (flag.toString() === "true") {
                                    callUnset(id);
                                }
                                else if (flag.toString() === "false") {
                                    callUnsetupdate(id);
                                }
                                else if (flag.toString() === "Undefined") {
                                    callset(id);
                                }

                            } catch (e) {
                                callset(id);
                            }
                        });
                    }
                 );
            } catch (e) {
            }
        }
        function callUnset(id) {
            try {
                ucode = localStorage.getItem("AttendeeId");
                db = openDatabase(shortName, version, displayName, maxSize);
                db.transaction(
                    function (transaction) {
                        transaction.executeSql('update tbl_FavoriteAttendee set flag="false" where ucode=? and attendeeid=?', [ucode, id], function (transaction, results) {
                        });
                    }
                 );
            } catch (e) {
            }
        }
        function callUnsetupdate(id) {
            try {
                ucode = localStorage.getItem("AttendeeId");
                db = openDatabase(shortName, version, displayName, maxSize);
                db.transaction(
                    function (transaction) {
                        transaction.executeSql('update tbl_FavoriteAttendee set flag="true" where ucode=? and attendeeid=?', [ucode, id], function (transaction, results) {
                        });
                    }
                 );
            } catch (e) {
            }
        }
        function callset(id) {
            try {
                ucode = localStorage.getItem("AttendeeId");
                db = openDatabase(shortName, version, displayName, maxSize);
                db.transaction(

                    function (transaction) {

                        transaction.executeSql('insert into tbl_FavoriteAttendee(ucode,attendeeid,flag) values(?,?,"true")', [ucode, id], function (transaction, results) { });
                    }
                 );
            } catch (e) {
            }
        }
        function changePage(id) {
            try {
                $("Attendee").remove();
                $.mobile.changePage($(id), { transition: "slide" });

            } catch (e) {
            }
        }
        $('#sync').live('pageshow', function () {
            localStorage.setItem("lastvistedpage", '#sync');
            try {
                db = openDatabase(shortName, version, displayName, maxSize);
                db.transaction(
                    function (transaction) {
                        transaction.executeSql(' select count(*) as c,event_code,eventname from tbl_SubEvent', [], function (transaction, results) {
                            if (results.rows.item(0).c > 0) {
                                $("#choicediv").css("visibility", "visible");
                                LoadChoiceList();
                            }
                            else {
                                $("#choicediv").css("visibility", "hidden");
                            }
                        });
                    }
                 );
            } catch (e) {
            }
        });
        function LoadChoiceList() {
            try {
                db = openDatabase(shortName, version, displayName, maxSize);
                db.transaction(
                    function (transaction) {
                        transaction.executeSql(' select event_code,eventname from tbl_SubEvent', [], function (transaction, results) {
                            $('#eventChoiceList').empty();
                            for (var i = 0; i < results.rows.length ; i++) {
                                renderTodoEventChoiceList(results.rows.item(i));

                            }

                        });
                    }
                 );
            } catch (e) {
            }
        }
        function renderTodoEventChoiceList(row) {
            try {

                var ID, EventName;
                if (row.id === null || row.id === "" || row.id === "Undefined")
                { ID = ""; }
                else
                { ID = row.id; }
                if (row.event_code === null || row.event_code === "" || row.event_code === "Undefined")
                { ecode = ""; }
                else
                { ecode = row.event_code; }
                if (row.eventname === null || row.eventname === "" || row.eventname === "Undefined")
                { EventName = ""; }
                else
                { EventName = row.eventname; }
                $('#eventChoiceList').append(
                         '<li>' +
                         '<a  href="#cpanel"  id="switchEvent' + ID + '" onclick="changeEventCode(\'' + ecode + '\')" data-theme="b">' +
                         '<h3>' + EventName + '</h3>' +
                          '</a>' +
                         '</li>'
                      );
                $("#eventChoiceList").listview('refresh');
            }
            catch (e) {
            }
        }
        function changeEventCode(eventcode) {
            localStorage.setItem("EventCode", eventcode);
        }
        $('#sync').live('pageshow', function () {
            localStorage.setItem("lastvistedpage", '#sync');
            getChoiceEventLoaded();
        });
        $('#Attendee').live('pageshow', function () {
            localStorage.setItem("lastvistedpage", '#Attendee');
            getAttendee();
        });
        $('#Exhibitor').live('pageshow', function () {
            localStorage.setItem("lastvistedpage", '#Exhibitor');
            getExihibitor();
        });
        $('#speaker').live('pageshow', function () {
            localStorage.setItem("lastvistedpage", '#speaker');
            getSpeaker();
        });
        $('#MyProfile').live('pageshow', function () {
            localStorage.setItem("lastvistedpage", '#MyProfile');
            getProfile();
        });
        $('#sponsor').live('pageshow', function () {
            localStorage.setItem("lastvistedpage", '#sponsor');
            getSponsor();
        });
        $('#twitter').live('pageshow', function () {
            localStorage.setItem("lastvistedpage", '#twitter');
            getTwitterLinkUrl();
        });
        $('#Events').live('pageshow', function () {
            localStorage.setItem("lastvistedpage", '#Events');
            getEvent();
        });
        $('#gmap').live('pageshow', function () {
            localStorage.setItem("lastvistedpage", '#gmap');
            getMap();
            var allInputs = $(':input');
            allInputs.val('');
        });
        $('#News').live('pageshow', function () {
            localStorage.setItem("lastvistedpage", '#News');
            getNews();
        });
        $('#Session').live('pageshow', function () {
            localStorage.setItem("lastvistedpage", '#Session');
            getSession();
        });
        $('#EventEvaluation').live('pageshow', function () {
            localStorage.setItem("lastvistedpage", '#EventEvaluation');
            getEventEvaluation();
            $('#EventEvaluation').page();
        });
        $('#PersonalSchedule').live('pageshow', function () {
            localStorage.setItem("lastvistedpage", '#PersonalSchedule');
            getPersonnalFavoriteCounts();
        });
        $('#FavAttendee').live('pageshow', function () {
            localStorage.setItem("lastvistedpage", '#FavAttendee');
            GetFavoriteAttendee();
        });
        $('#FavExhibitor').live('pageshow', function () {
            localStorage.setItem("lastvistedpage", '#FavExhibitor');
            GetFavoriteExhibitor();
        });
        $('#FavSpeaker').live('pageshow', function () {
            localStorage.setItem("lastvistedpage", '#FavSpeaker');
            GetFavoriteSpeaker();
        });
        $('#FavSession').live('pageshow', function () {
            localStorage.setItem("lastvistedpage", '#FavSession');
            GetFavoriteSession();
        });
        $('#AppUpdateScreen').live('pageshow', function () {
            localStorage.setItem("lastvistedpage", '#AppUpdateScreen');
        });
        $('#sponsorDetails').live('pageshow', function () {
            var ID = localStorage.getItem("SponsorDetailsID");
            if (typeof (ID) != 'undefined') {
                localStorage.setItem("lastvistedpage", '#sponsorDetails');
                onSponsorClick(ID);
            }
            else {
                $.mobile.changePage("sponsor");
            }
        });
        $('#FavSpeakerDetails').live('pageshow', function () {
            var ID = localStorage.getItem("SpeakerDetailsIDfav");
            if (typeof (ID) != 'undefined') {
                localStorage.setItem("lastvistedpage", '#FavSpeakerDetails');
                getClickSpeakerFav(ID);
            }
            else {
                $.mobile.changePage("PersonalSchedule");
            }
        });
        $('#SpeakerDetails').live('pageshow', function () {
            var ID = localStorage.getItem("SpeakerDetailsID");
            if (typeof (ID) != 'undefined') {
                localStorage.setItem("lastvistedpage", '#SpeakerDetails');
                getClickSpeaker(ID);
            }
            else {
                $.mobile.changePage("speaker");
            }
        });
        $('#instruction').live('pageshow', function () {
            localStorage.setItem("lastvistedpage", '#instruction');
        });
        $('#FavExhiDetails').live('pageshow', function () {
            var ID = localStorage.getItem("FavExhiDetailsID");
            if (typeof (ID) != 'undefined') {
                localStorage.setItem("lastvistedpage", '#FavExhiDetails');
                getExhibitorFavClick(ID);
            }
            else {
                $.mobile.changePage("PersonalSchedule");
            }
        });
        $('#ExhibitorDetails').live('pageshow', function () {
            var ID = localStorage.getItem("ExhibitorDetailsID");
            if (typeof (ID) != 'undefined') {
                localStorage.setItem("lastvistedpage", '#ExhibitorDetails');
                getExhibitorClick(ID);
            }
            else {
                $.mobile.changePage("Exhibitor");
            }
        });
        $('#newsDetails').live('pageshow', function () {
            var ID = localStorage.getItem("newsDetailsID");
            if (typeof (ID) != 'undefined') {
                localStorage.setItem("lastvistedpage", '#newsDetails');
                onNewsClick(ID);
            }
            else {
                $.mobile.changePage("News");
            }
        });
        $('#AttendeeDetailsFav').live('pageshow', function () {
            var ID = localStorage.getItem("AttendeeDetailIdfev");
            if (typeof (ID) != 'undefined') {
                localStorage.setItem("lastvistedpage", '#AttendeeDetailsFav');
                getClickFav(ID);
            }
            else {
                $.mobile.changePage("PersonalSchedule");
            }

        });
        $('#AttendeeDetails').live('pageshow', function () {
            var ID = localStorage.getItem("AttendeeDetailId");
            if (typeof (ID) != 'undefined') {
                localStorage.setItem("lastvistedpage", '#AttendeeDetails');
                getClick(ID);
            }
            else {
                $.mobile.changePage("Attendee");
            }
        });
        $('#eventDetails').live('pageshow', function () {
            var ID = localStorage.getItem("eventDetailId");
            if (typeof (ID) != 'undefined') {
                localStorage.setItem("lastvistedpage", '#eventDetails');
                getClickEvent(ID);
            }
            else {
                $.mobile.changePage("Events");
            }
        });
        $('#favsessionDetails').live('pageshow', function () {
            var ID = localStorage.getItem("sessionDetailfevId");
            if (typeof (ID) != 'undefined') {
                localStorage.setItem("lastvistedpage", '#favsessionDetails');
                getClickSessionFav(ID);
            }
            else {
                $.mobile.changePage("PersonalSchedule");
            }
        });
        $('#sessionDetails').live('pageshow', function () {
            var ID = localStorage.getItem("sessionDetailId");
            if (typeof (ID) != 'undefined') {
                localStorage.setItem("lastvistedpage", '#sessionDetails');
                getClickSession(ID);
            }
            else {
                $.mobile.changePage("Session");
            }

        });
        $('#cpanel').live('pageshow', function () {
            var CheckinStatus = localStorage.getItem("Check");
            if (!CheckinStatus) {
                document.getElementById("checkinheader").innerHTML = "Check In";
            }
            else {
                document.getElementById("checkinheader").innerHTML = CheckinStatus;
            }
            localStorage.setItem("lastvistedpage", '#cpanel');
            getTwitterLinkUrl();
        });
        $('#home').live('pageshow', function () {
            localStorage.setItem("lastvistedpage", '#home');
        });
        $('#eventEvalQuestions').live('pageshow', function () {
            localStorage.setItem("lastvistedpage", '#eventEvalQuestions');
        });
        $('#notification').live('pageshow', function () {
            localStorage.setItem("lastvistedpage", '#notification');
            getNotifications();
        });
        $('#livepoll').live('pageshow', function () {
            localStorage.setItem("lastvistedpage", '#livepoll');
        });
        $('#Messages').live('pageshow', function () {
            localStorage.setItem("lastvistedpage", '#Messages');
            $().toastmessage('showToast', {
                text: 'Refreshing Inbox ...',
                sticky: false,
                position: 'top-right',
                type: 'success',
                closeText: '',
                close: function () {
                }
            });
            window.setTimeout(function () {
                MessageToServer();
                MessageFromServer();
            }, 1000);
            GetReceivedMessages();
        });
        $(document).live("pagebeforeshow", "#map_page", function () {
            navigator.geolocation.getCurrentPosition(locSuccess, locError);
        });
        $(document).on('click', '#directions-button', function (e) {
            e.preventDefault();
            calculateRoute();
        });
        Number.prototype.padLeft = function (base, chr) {
            var len = (String(base || 10).length - String(this).length) + 1;
            return len > 0 ? new Array(len).join(chr || '0') + this : this;
        }
        function GetCheckInAvailable() {

            var d = new Date,
            dformat = [d.getDate().padLeft(), (d.getMonth() + 1).padLeft(), d.getFullYear()].join('/') + ' ' + [d.getHours().padLeft(), d.getMinutes().padLeft(), d.getSeconds().padLeft()].join(':');
            if (navigator.onLine) {
                ucode = localStorage.getItem("EventCode");
                PageMethods.AttendeeCheckIn(AttendeeId, ecode, ucode, dformat, onSucess, onError)
                function onSucess() {
                    if (document.getElementById("checkinheader").innerHTML === "Check In") {
                        document.getElementById("checkinheader").innerHTML = "Check Out";
                        localStorage.setItem("Check", "Check Out");
                        $().toastmessage('showToast', {
                            text: 'Check In Success...',
                            sticky: false,
                            position: 'top-right',
                            type: 'success',
                            closeText: '',
                            close: function () { }
                        });
                    }
                    else {
                        localStorage.setItem("Check", "Check In");
                        document.getElementById("checkinheader").innerHTML = "Check In";
                        $().toastmessage('showToast', {
                            text: 'Check Out Success...',
                            sticky: false,
                            position: 'top-right',
                            type: 'success',
                            closeText: '',
                            close: function () {
                            }
                        });
                    }
                }
                function onError() {
                    $().toastmessage('showToast', {
                        text: 'Cant checkin Now...',
                        sticky: false,
                        position: 'top-right',
                        type: 'error',
                        closeText: '',
                        close: function () {
                        }
                    });
                }
            }
            else {
                var tempdb = db;
                db.transaction(
                  function (transaction) {
                      transaction.executeSql('INSERT INTO tbl_Checkin(event_code,user_code, logindatetime) values(?,?,?)',
                             [ecode.toString(), ucode.toString(), dformat.toString()]);
                      if (document.getElementById("checkinheader").innerHTML === "Check In") {
                          document.getElementById("checkinheader").innerHTML = "Check out"
                          $().toastmessage('showToast', {
                              text: 'Check In Success.. ...',
                              sticky: false,
                              position: 'top-right',
                              type: 'success',
                              closeText: '',
                              close: function () {
                              }
                          });
                      }
                      else {
                          document.getElementById("checkinheader").innerHTML = "Check In";
                          $().toastmessage('showToast', {
                              text: 'Check Out Success...',
                              sticky: false,
                              position: 'top-right',
                              type: 'success',
                              closeText: '',
                              close: function () {
                              }
                          });
                      }
                  }
               );
            }
        }
        function sendCheckinDataToServer() {
            AttendeeCheckinArr = new Array();
            db = openDatabase(shortName, version, displayName, maxSize);
            db.transaction(
              function (transaction) {
                  transaction.executeSql('SELECT * from tbl_Checkin', [], function (transaction, results) {
                      for (i = 0; i < results.rows.length; i++) {
                          var AttendeeChk =
                              {
                                  ID: results.rows.item(i).id,
                                  Ucode: results.rows.item(i).user_code,
                                  Ecode: results.rows.item(i).event_code,
                                  checkinDatetime: results.rows.item(i).logindatetime,
                                  Flag: results.rows.item(i).flag
                              }
                          AttendeeCheckinArr.push(AttendeeChk);
                      }
                      var serializedEmployee = Sys.Serialization.JavaScriptSerializer.serialize(AttendeeCheckinArr);
                      PageMethods.AttendeeCheckIn(serializedEmployee, callBackUpdateCustomer);
                  });
              }
           );
        }
        function deleteCheckinData() {
            var tempdb = db;
            db.transaction(
              function (transaction) {
                  transaction.executeSql('delete from tbl_Checkin', []);
              }
            );
        }
        function insertCheckinData(dformat) {
            var tempdb = db;
            db.transaction(
              function (transaction) {
                  transaction.executeSql('INSERT INTO tbl_Checkin(event_code,user_code, logindatetime,flag) values(?,?,?,?)',
                        [ecode.toString(), ucode.toString(), dformat.toString(), 'Checkin']);
              }
            );
        }
        function getNotifications() {
            db = openDatabase(shortName, version, displayName, maxSize);
            db.transaction(
                function (transaction) {
                    transaction.executeSql('select * from tbl_Notification ', [], function (transaction, results) {
                        $('#notificationList').empty();
                        if (results.rows.length === 0) {
                            $('#notificationList').empty();
                            $('#notificationList').listview('refresh');
                        }
                        else {
                            for (i = 0; i < results.rows.length; i++) {
                                renderTodonotificationList(results.rows.item(i));
                            }
                        }
                    });
                }
             );
        }

        function renderTodonotificationList(row) {
            try {

                var ID, Message, DateOfNotification;
                if (row.id === null || row.id === "" || row.id === "Undefined")
                { ID = ""; }
                else
                { ID = row.id; }
                if (row.message === null || row.message === "" || row.message === "Undefined")
                { Message = ""; }
                else
                { Message = row.message; }
                if (row.notificationdate === null || row.notificationdate === "" || row.notificationdate === "Undefined")
                { DateOfNotification = ""; }
                else
                { DateOfNotification = row.notificationdate; }
                $('#notificationList').append(
                         '<li>' +
                         '<a><h3>' + Message + '</h3>' +
                         '<p>' + DateOfNotification + '</p></a>' +
                         '<a class="deleteMe" data-icon="delete" id="deleteNotification' + ID + '" data-theme="b" onclick="deteleNotification(' + ID + ')"></a>' +
                         '</li>'
                      );
                $("#notificationList").listview('refresh');
                $("#deleteNotification" + ID + "").button();
            }
            catch (e) {
            }
        }

        function deteleNotification(ID) {
            if (navigator.onLine) {
                PageMethods.DeleteNotification(ID, onSucess, onError)
                function onSucess() {

                    $().toastmessage('showToast', {
                        text: 'Notification Deleted Successfully...',
                        sticky: false,
                        position: 'top-right',
                        type: 'success',
                        closeText: '',
                        close: function () {
                        }
                    });
                    db = openDatabase(shortName, version, displayName, maxSize);
                    db.transaction(

                        function (transaction) {

                            transaction.executeSql('delete from tbl_Notification where id = ?', [ID], function (transaction, results) {
                                getNotifications();
                            });
                        }
                     );
                }
                function onError() {
                    $().toastmessage('showToast', {
                        text: 'Notification Deletion unsuccessfull...',
                        sticky: false,
                        position: 'top-right',
                        type: 'error',
                        closeText: '',
                        close: function () {
                        }
                    });
                }
            }
            else {

                db = openDatabase(shortName, version, displayName, maxSize);
                db.transaction(
                    function (transaction) {
                        transaction.executeSql('delete from tbl_Notification where id = ?', [ID], function (transaction, results) {

                            $().toastmessage('showToast', {
                                text: 'Notification Deleted Successfully...',
                                sticky: false,
                                position: 'top-right',
                                type: 'success',
                                closeText: '',
                                close: function () {
                                }
                            });
                        });
                    }
                 );
            }
        }
        function GetFavoriteSession() {
            db = openDatabase(shortName, version, displayName, maxSize);
            db.transaction(
                function (transaction) {
                    transaction.executeSql('select tbl_Session.id ,tbl_Session.event_code,tbl_Session.sessionTitle, tbl_Session.sessionDate,tbl_Session.sessionStartTime,tbl_Session.sessionFinishTime ,tbl_Session.sessionLocation,tbl_Session.overview,tbl_Session.sessionSpeakerFname,tbl_FavoriteSession.ucode , tbl_FavoriteSession.sessionid,tbl_FavoriteSession.flag from tbl_Session left outer join tbl_FavoriteSession on tbl_Session.id = tbl_FavoriteSession.sessionid where tbl_Session.event_code=?', [ecode], function (transaction, results) {
                        $('#SessionListFav').empty();
                        if (results.rows.length === 0) {
                            $('#SessionListFav').empty();
                            $('#SessionListFav').listview('refresh');
                        }
                        else {
                            for (i = 0; i < results.rows.length; i++) {
                                renderTodoSessionFav(results.rows.item(i));
                            }
                        }
                    });
                }
             );
        }

        function renderTodoSessionFav(row) {

            try {
                var ID, SessionName, SessionLocation, SessionStartTime, SessionEndTime, Flag;
                if (row.id === null || row.id === "" || row.id === "Undefined")
                { ID = ""; }
                else
                { ID = row.id; }
                if (row.sessionTitle === null || row.sessionTitle === "" || row.sessionTitle === "Undefined")
                { SessionName = ""; }
                else
                { SessionName = row.sessionTitle; }
                if (row.sessionLocation === null || row.sessionLocation === "" || row.sessionLocation === "Undefined")
                { SessionLocation = ""; }
                else
                { SessionLocation = row.sessionLocation; }
                if (row.sessionStartTime === null || row.sessionStartTime === "" || row.sessionStartTime === "Undefined")
                { SessionStartTime = ""; }
                else
                { SessionStartTime = row.sessionStartTime; }
                if (row.sessionFinishTime === null || row.sessionFinishTime === "" || row.sessionFinishTime === "Undefined")
                { SessionEndTime = ""; }
                else
                { SessionEndTime = row.sessionFinishTime; }
                if (row.flag === null || row.flag === "" || row.flag === "Undefined" || row.flag === "false")
                { Flag = ""; }
                else
                { Flag = row.flag }

                if (Flag != "") {
                    $('#SessionListFav').append(
                       '<li>' +
                              '<a href="#favsessionDetails"   onclick="getClickSessionFav(' + ID + ')">' +
                                    '<h3 class="ui-li-heading">' + SessionName + '</h3>' +
                                    '<p class="ui-li-heading">' + SessionLocation + '</p>' +
                                    '<p class="ui-li-heading">' + SessionStartTime + ' To ' + SessionEndTime + '</p>' +
                                 '<span class="ui-li-count" style="border:0px; font-size:18px"><a href="#" style="padding:0px; margin:0px; border:0px; background:round" data-role="button" data-icon="star" data-iconpos="notext">star</a></span></span>' +
                             '</a> ' +
                      '</li>'
                      );
                }
                $('#SessionListFav').listview('refresh');
            } catch (e) {
            }

        }
        function getClickSessionFav(ID) {
            db = openDatabase(shortName, version, displayName, maxSize);
            db.transaction(

                function (transaction) {
                    transaction.executeSql('select tbl_Session.id ,tbl_Session.event_code,tbl_Session.sessionTitle, tbl_Session.sessionDate,tbl_Session.sessionStartTime,tbl_Session.sessionFinishTime ,tbl_Session.sessionLocation,tbl_Session.overview,tbl_Session.sessionSpeakerFname,tbl_Session.sessionspeakerLname from tbl_Session where tbl_Session.id= ?', [ID], function (transaction, results) {
                        if (results.rows.length === 0) {
                        }
                        else {
                            var name = results.rows.item(0).sessionTitle;
                            var speakername = results.rows.item(0).sessionSpeakerFname + ' ' + results.rows.item(0).sessionspeakerLname;
                            $('#sessionhiddenidfav').val(ID);
                            $('#txtSessionNamefav').val(name);
                            $('#txtSessionLocationfav').val(results.rows.item(0).sessionLocation);
                            $('#txtsessionSpeakerfav').val(results.rows.item(0).sessionFinishTime);
                            $('#txtsessionstarttimefav').val(speakername);
                            $('#txtsessionfinishtimeFav').val(results.rows.item(0).sessionStartTime);
                            $('#txtSessionOverviewFav').val(results.rows.item(0).sessionFinishTime);
                            $('#txtSessionNoteFav').val(results.rows.item(0).overview);
                        }
                    });
                }
             );
        }

        function getClickSessionOfSpeaker(ID) {
            db = openDatabase(shortName, version, displayName, maxSize);
            db.transaction(

                function (transaction) {
                    transaction.executeSql('select tbl_Session.id ,tbl_Session.event_code,tbl_Session.sessionTitle, tbl_Session.sessionDate,tbl_Session.sessionStartTime,tbl_Session.sessionFinishTime ,tbl_Session.sessionLocation,tbl_Session.overview,tbl_Session.sessionSpeakerFname,tbl_Session.sessionspeakerLname from tbl_Session where tbl_Session.id= ?', [ID], function (transaction, results) {
                        if (results.rows.length === 0) {
                        }
                        else {

                            var name = results.rows.item(0).sessionTitle;
                            var speakername = results.rows.item(0).sessionSpeakerFname + ' ' + results.rows.item(0).sessionspeakerLname;
                            $('#sessionhiddenidfavofsession').val(ID);
                            $('#txtSessionNamefavofsession').val(name);
                            $('#txtSessionLocationfavofsession').val(results.rows.item(0).sessionLocation);
                            $('#txtsessionSpeakerfavofsession').val(results.rows.item(0).sessionFinishTime);
                            $('#txtsessionstarttimefavofsession').val(speakername);
                            $('#txtsessionfinishtimeFavofsession').val(results.rows.item(0).sessionStartTime);
                            $('#txtSessionOverviewFavofsession').val(results.rows.item(0).sessionFinishTime);
                            $('#txtSessionNoteFavofsession').val(results.rows.item(0).overview);

                        }

                    });


                }

             );
        }

        function GetFavoriteAttendee() {

            try {
                db = openDatabase(shortName, version, displayName, maxSize);
                db.transaction(
                    function (transaction) {
                        transaction.executeSql('select tbl_Attendee.id,tbl_Attendee.event_code,tbl_Attendee.Attendee_Level,tbl_Attendee.Title, tbl_Attendee.Firstname, tbl_Attendee.Lastname,tbl_Attendee.Position,tbl_Attendee.Category_Industry,tbl_Attendee.Address,tbl_Attendee.Phone_Number,tbl_Attendee.Email,tbl_Attendee.Biography,tbl_Attendee.Website,tbl_Attendee.company,tbl_Attendee.MIMEtype,tbl_Attendee.checkin,tbl_Attendee.offlineUpdate,tbl_FavoriteAttendee.ucode, tbl_FavoriteAttendee.attendeeid,tbl_FavoriteAttendee.flag from tbl_Attendee left outer join tbl_FavoriteAttendee on tbl_Attendee.id = tbl_FavoriteAttendee.attendeeid where tbl_Attendee.event_code=?', [ecode], function (transaction, results) {

                            if (results.rows.length === 0) {
                                $('#listfavAttendee').empty();
                            }
                            else {
                                $('#listfavAttendee').empty();
                                for (i = 0; i < results.rows.length; i++) {
                                    renderTodofav(results.rows.item(i));
                                }
                            }
                        });
                    }
                 );
            } catch (e) {
            }

        }

        function renderTodofav(row) {

            try {

                var ID, MIMEtype, Firstname, Lastname, Flag;
                if (row.id === null || row.id === "" || row.id === "Undefined")
                { ID = ""; }
                else
                { ID = row.id }
                if (row.MIMEtype === null || row.MIMEtype === "" || row.MIMEtype === "Undefined")
                { MIMEtype = ""; }
                else
                { MIMEtype = row.MIMEtype; }
                if (row.Title === null || row.Title === "" || row.Title === "Undefined")
                { Title = ""; }
                else
                { Title = row.Title; }
                if (row.Firstname === null || row.Firstname === "" || row.Firstname === "Undefined")
                { Firstname = ""; }
                else
                { Firstname = row.Firstname; }
                if (row.Lastname === null || row.Lastname === "" || row.Lastname === "Undefined")
                { Lastname = ""; }
                else
                { Lastname = row.Lastname; }
                if (row.Position === null || row.Position === "" || row.Position === "Undefined")
                { Position = ""; }
                else
                { Position = row.Position; }
                if (row.company === null || row.company === "" || row.company === "Undefined")
                { Company = ""; }
                else
                { Company = row.company; }
                if (row.flag === null || row.flag === "" || row.flag === "Undefined" || row.flag === "false")
                { Flag = ""; }
                else
                { Flag = row.flag; }

                if (Flag != "") {
                    $('#listfavAttendee').append(
                       '<li class="listex">' +
                             '<a href="#AttendeeDetailsFav"   onclick="getClickFav(' + ID + ');"><img src="imagesattaindee/' + ID + MIMEtype + '" class="ui-li-thumb" border="0" />' +
                                   '<h3 class="ui-li-heading">' + Firstname + ' ' + Lastname + '</h3>' +
                                    '<p class="ui-li-desc">' + Position + '</p>' +
                                    '<p class="ui-li-desc">' + Company + '</p>' +
                                 '<span class="ui-li-count" style="border:0px; font-size:18px"><a href="#" style="padding:0px; margin:0px; border:0px; background:round" data-role="button" data-icon="star" data-iconpos="notext">star</a></span></span>' +
                             '</a> ' +
                      '</li>'
                      );
                }
                $('#listfavAttendee').listview('refresh');
            }
            catch (e) {
            }

        }
        function getClickFav(ID) {
            db = openDatabase(shortName, version, displayName, maxSize);
            db.transaction(

                function (transaction) {
                    transaction.executeSql('select tbl_Attendee.id,tbl_Attendee.facebook,tbl_Attendee.twitter,tbl_Attendee.linkedin,tbl_Attendee.event_code,tbl_Attendee.Attendee_Level,tbl_Attendee.Title, tbl_Attendee.Firstname, tbl_Attendee.Lastname,tbl_Attendee.Position,tbl_Attendee.Category_Industry,tbl_Attendee.Address,tbl_Attendee.Phone_Number,tbl_Attendee.Email,tbl_Attendee.Biography,tbl_Attendee.Website,tbl_Attendee.company,tbl_Attendee.MIMEtype,tbl_Attendee.checkin,tbl_Attendee.offlineUpdate from tbl_Attendee where  tbl_Attendee.id = ?', [ID], function (transaction, results) {
                        if (results.rows.length === 0) {
                            $('#listfavAttendee').empty();
                        }
                        else {
                            $('#listfavAttendee').empty();
                            for (i = 0; i < results.rows.length; i++) {
                                renderTodo(results.rows.item(0));
                                localStorage.setItem("AttendeeDetailIdfev", ID); document.getElementById('AttendeeImageFav').src = 'imagesattaindee/' + results.rows.item(0).id + results.rows.item(0).MIMEtype;
                                var name = results.rows.item(0).Title + " " + results.rows.item(0).Firstname + " " + results.rows.item(0).Lastname;
                                $('#AttendeeHiddenIdFav').val(ID);
                                $('#toAttendeeId').val(ID);
                                $('#Attendeenamefav').val(name);
                                $('#AttendeeCompanyfav').val(results.rows.item(0).company);
                                $('#txtCategoryfav').val(results.rows.item(0).Category_Industry);
                                $('#txtWebsitefav').val(results.rows.item(0).Website);
                                $('#txtBioGrapghyfav').val(results.rows.item(0).Biography);
                                var aTag = document.getElementById('fblinkattendeefav');
                                aTag.setAttribute('href', "http://" + results.rows.item(0).facebook.toString());
                                var aTag1 = document.getElementById('twitterlinkattendeefav');
                                aTag1.setAttribute('href', "http://" + results.rows.item(0).twitter.toString());
                                var aTag2 = document.getElementById('linkedlinkattendeefav');
                                aTag2.setAttribute('href', "http://" + results.rows.item(0).linkedin.toString());

                                var node = document.getElementById("AttendeeWeblink2");
                                node.innerHTML = "<div Class='rounded-corners'> <a href='http://" + results.rows.item(0).Website + "' >" + results.rows.item(0).Website + "</a> </div></br>";


                            }
                        }
                    });
                }
             );
        }

        function GetFavoriteExhibitor() {

            try {
                db = openDatabase(shortName, version, displayName, maxSize);
                db.transaction(

                    function (transaction) {

                        transaction.executeSql('select tbl_Exhibitor.id,tbl_Exhibitor.event_code,tbl_Exhibitor.company,tbl_Exhibitor.standno,tbl_Exhibitor.catagory,tbl_Exhibitor.address,tbl_Exhibitor.phoneno,tbl_Exhibitor.email,tbl_Exhibitor.biography,tbl_Exhibitor.contactname,tbl_Exhibitor.website,tbl_Exhibitor.position, tbl_Exhibitor.sponsorshiplevel, tbl_Exhibitor.MIMEtype, tbl_FavoriteExihibitor.ucode, tbl_FavoriteExihibitor.exhiid, tbl_FavoriteExihibitor.flag from tbl_Exhibitor left outer join tbl_FavoriteExihibitor on tbl_Exhibitor.id = tbl_FavoriteExihibitor.exhiid where tbl_Exhibitor.event_code = ?', [ecode], function (transaction, results) {

                            $('#listfavExhi').empty();
                            $('#listfavExhi').listview('refresh');
                            if (results.rows.length === 0) {
                                $('#listfavExhi').empty();
                                $('#listfavExhi').listview('refresh');
                            }
                            else {
                                for (i = 0; i < results.rows.length; i++) {
                                    renderTodoExihibitorsFav(results.rows.item(i));
                                }
                            }
                        });


                    }

                 );

            } catch (e) {
            }
        }
        function renderTodoExihibitorsFav(row) {

            try {

                var ID, Contactname, Position, Company, Category, Website, biography, MIMEtype, Flag;

                ID = row.id;
                MIMEtype = row.MIMEtype;
                Flag = row.flag;

                if (row.id === null || row.id === "" || row.id === "undefined")
                { ID = ""; }
                else
                { ID = row.id }

                if (row.MIMEtype === null || row.MIMEtype === "" || row.MIMEtype === "undefined")
                { MIMEtype = ""; }
                else
                { MIMEtype = row.MIMEtype }
                if (row.contactname === null || row.contactname === "" || row.contactname === "undefined")
                { Contactname = ""; }
                else
                { Contactname = row.contactname }
                if (row.company === null || row.company === "" || row.company === "undefined")
                { Company = ""; }
                else
                { Company = row.company }
                if (row.website === null || row.website === "" || row.website === "undefined")
                { Website = ""; }
                else
                { Website = row.website }
                if (row.catagory === null || row.catagory === "" || row.website === "undefined")
                { Category = ""; }
                else
                { Category = row.catagory }
                if (row.biography === null || row.biography === "" || row.biography === "undefined")
                { biography = ""; }
                else
                { biography = row.biography }
                if (row.position === null || row.position === "" || row.position === "undefined")
                { Position = ""; }
                else
                { Position = row.position }
                if (row.flag === null || row.flag === "" || row.flag === "Undefined" || row.flag === "false")
                { Flag = ""; }
                else
                { Flag = row.flag }
                if (Flag != "") {
                    $('#listfavExhi').append(
                         '<li class="listex">' +
                             '<a href="#FavExhiDetails"   onclick="getExhibitorFavClick(' + ID + ');"><img src="imagesExihibitor/' + ID + MIMEtype + '" class="ui-li-thumb" border="0" />' +
                                    '<h3 class="ui-li-heading">' + Contactname + '</h3>' +
                                   '<p class="ui-li-desc">' + Position + '</p>' +
                                   '<p class="ui-li-desc">' + Company + '</p>' +
                                 '<span class="ui-li-count" style="border:0px; font-size:18px"><a href="#" style="padding:0px; margin:0px; border:0px; background:round" data-role="button" data-icon="star" data-iconpos="notext">star</a></span></span>' +
                             '</a> ' +
                      '</li>'
                    );
                }
                $('#listfavExhi').listview('refresh');

            }
            catch (e) {
            }
        }

        function getExhibitorFavClick(ID) {

            db = openDatabase(shortName, version, displayName, maxSize);
            db.transaction(

                function (transaction) {
                    transaction.executeSql('select tbl_Exhibitor.id,tbl_Exhibitor.facebook,tbl_Exhibitor.twitter,tbl_Exhibitor.linkedin,tbl_Exhibitor.event_code,tbl_Exhibitor.company,tbl_Exhibitor.standno,tbl_Exhibitor.catagory,tbl_Exhibitor.address,tbl_Exhibitor.phoneno,tbl_Exhibitor.email,tbl_Exhibitor.biography,tbl_Exhibitor.contactname,tbl_Exhibitor.website,tbl_Exhibitor.position, tbl_Exhibitor.sponsorshiplevel, tbl_Exhibitor.MIMEtype from tbl_Exhibitor where tbl_Exhibitor.id =  ?', [ID], function (transaction, results) {
                        if (results.rows.length === 0) {
                            $('#listfavExhi').empty();
                        }
                        else {
                            $('#listfavExhi').empty();
                            for (i = 0; i < results.rows.length; i++) {
                                renderTodo(results.rows.item(0));
                                document.getElementById('ExhibitorImagefav').src = 'imagesExihibitor/' + results.rows.item(0).id + results.rows.item(0).MIMEtype;
                                var name = results.rows.item(0).contactname;
                                localStorage.setItem("FavExhiDetailsID", ID);
                                $('#exhibitorhiddenidFav').val(ID);
                                $('#toExhibitorId').val(ID);
                                $('#txtExhiNamefav').val(name);
                                $('#txtExhiCompNameFav').val(results.rows.item(0).company);
                                $('#txtExhiCatNameFav').val(results.rows.item(0).catagory);
                                $('#txtExhiBioFav').val(results.rows.item(0).biography);
                                $('#txtExhiEmailFav').val(results.rows.item(0).email);
                                $('#txtExhiPhoneFav').val(results.rows.item(0).phoneno);
                                $('#txtExhiAddressFav').val(results.rows.item(0).address);
                                $('#txtExhiPositionFav').val(results.rows.item(0).position);
                                var aTag = document.getElementById('exhibitorfacebooklinkfav');
                                aTag.setAttribute('href', "http://" + results.rows.item(0).facebook.toString());
                                var aTag1 = document.getElementById('exhibitortwitterlinkfav');
                                aTag1.setAttribute('href', "http://" + results.rows.item(0).twitter.toString());
                                var aTag2 = document.getElementById('exhibitorlinkedinlinkfav');
                                aTag2.setAttribute('href', "http://" + results.rows.item(0).linkedin.toString());
                                var node = document.getElementById("exhiWebLink1");
                                node.innerHTML = "<div Class='rounded-corners'> <a href='http://" + results.rows.item(0).website + "' target='_blank' >" + results.rows.item(0).website + "</a> </div></br>";
                            }
                        }
                    });
                }

             );
        }
        function GetFavoriteSpeaker() {

            db = openDatabase(shortName, version, displayName, maxSize);
            db.transaction(

                function (transaction) {

                    transaction.executeSql('select tbl_FavoriteSpeaker.ucode, tbl_FavoriteSpeaker.speakerid,tbl_FavoriteSpeaker.flag, tbl_Speaker.id ,tbl_Speaker.event_code ,tbl_Speaker.title , tbl_Speaker.firstname, tbl_Speaker.lastname,tbl_Speaker.position ,tbl_Speaker.categoryIndustry,tbl_Speaker.company ,tbl_Speaker.address ,tbl_Speaker.phoneno ,tbl_Speaker.email ,tbl_Speaker.website,tbl_Speaker.biography,tbl_Speaker.MIMEtype from tbl_Speaker left outer join tbl_FavoriteSpeaker on tbl_Speaker.id = tbl_FavoriteSpeaker.speakerid where tbl_Speaker.event_code=?', [ecode], function (transaction, results) {
                        $('#speakerFavlist').empty();
                        if (results.rows.length === 0) {
                            $('#speakerFavlist').empty();
                            $('#speakerFavlist').listview('refresh');
                        }
                        else {
                            for (i = 0; i < results.rows.length; i++) {
                                renderTodoSpeakersFav(results.rows.item(i));
                            }
                        }
                    });


                }

             );

        }


        function renderTodoSpeakersFav(row) {

            try {
                var ID, Title, Firstname, Lastname, Position, Company, Website, Category_Industry, Address, Email, Biography, MIMEtype, Flag;
                if (row.id === null || row.id === "" || row.id == "undefined")
                { ID = ""; }
                else
                { ID = row.id; }
                if (row.MIMEtype === null || row.MIMEtype === "" || row.MIMEtype == "undefined")
                { MIMEtype = ""; }
                else
                { MIMEtype = row.MIMEtype }
                if (row.title === null || row.title === "" || row.title == "undefined")
                { title = ""; }
                else
                { Title = row.title; }
                if (row.firstname === null || row.firstname === "" || row.firstname === "undefined")
                { Firstname = ""; }
                else
                { Firstname = row.firstname; }
                if (row.lastname === null || row.lastname === "" || row.lastname === "undefined")
                { Lastname = ""; }
                else
                { Lastname = row.lastname; }
                if (row.position === null || row.position === "" || row.position === "undefined")
                { Position = ""; }
                else
                { Position = row.position; }
                if (row.company === null || row.company === "" || row.company === "undefined")
                { Company = ""; }
                else
                { Company = row.company; }
                if (row.website === null || row.website === "" || row.website === "undefined")
                { Website = ""; }
                else
                { Website = row.website; }
                if (row.categoryindustry === null || row.categoryindustry === "" || row.categoryindustry === "undefined")
                { Category_Industry = ""; }
                else
                { Category_Industry = row.categoryindustry; }
                if (row.address === null || row.address === "" || row.address === "undefined")
                { Address = ""; }
                else
                { Address = row.address; }
                if (row.email === null || row.email === "" || row.email === "undefined")
                { Email = ""; }
                else
                { Email = row.email; }
                if (row.biography === null || row.biography === "" || row.biography === "undefined")
                { Biography = ""; }
                else
                { Biography = row.biography; }
                if (row.flag === null || row.flag === "" || row.flag === "Undefined" || row.flag === "false")
                { Flag = ""; }
                else
                { Flag = row.flag; }
                if (Flag != "") {
                    $('#speakerFavlist').append(

                    '<li class="listex">' +
                            '<a href="#FavSpeakerDetails"   onclick="getClickSpeakerFav(' + ID + ');"><img src="imagesSpeaker/' + ID + MIMEtype + '" class="ui-li-thumb" border="0" />' +
                                '<h3 class="ui-li-heading">' + Title + " " + Firstname + " " + Lastname + '</h3>' +
                                '<p class="ui-li-desc">' + Position + '</p>' +
                                '<p class="ui-li-desc">' + Company + '</p>' +
                                '<span class="ui-li-count" style="border:0px; font-size:18px"><a href="#" style="padding:0px; margin:0px; border:0px; background:round" data-role="button" data-icon="star" data-iconpos="notext">star</a></span></span>' +
                            '</a> ' +
                    '</li>'
                     );
                }
                $('#speakerFavlist').listview('refresh');

            } catch (e) {
            }

        }

        function getClickSpeakerFav(ID) {
            db = openDatabase(shortName, version, displayName, maxSize);
            db.transaction(
                function (transaction) {
                    transaction.executeSql('select  tbl_Speaker.id,tbl_Speaker.facebook,tbl_Speaker.twitter,tbl_Speaker.linkedin ,tbl_Speaker.event_code ,tbl_Speaker.title , tbl_Speaker.firstname, tbl_Speaker.lastname,tbl_Speaker.position ,tbl_Speaker.categoryIndustry,tbl_Speaker.company ,tbl_Speaker.address ,tbl_Speaker.phoneno ,tbl_Speaker.email ,tbl_Speaker.website,tbl_Speaker.biography,tbl_Speaker.MIMEtype from tbl_Speaker where tbl_Speaker.id = ?', [ID], function (transaction, results) {
                        if (results.rows.length === 0) {
                            $('#speakerFavlist').empty();
                        }
                        else {
                            for (i = 0; i < results.rows.length; i++) {
                                renderTodo(results.rows.item(0));
                                document.getElementById('SpeakerImagefav').src = 'imagesSpeaker/' + results.rows.item(0).id + results.rows.item(0).MIMEtype;
                                var name = results.rows.item(0).title + ' ' + results.rows.item(0).firstname + ' ' + results.rows.item(0).lastname;
                                localStorage.setItem("sessionDetailfevId", ID);
                                $('#speakerhiddenidFav').val(ID);
                                $('#toSpeakerId').val(ID);
                                $('#txtSpeakerNameFav').val(name);
                                $('#txtSpeakerCompFav').val(results.rows.item(0).company);
                                $('#txtSpeakerCatFav').val(results.rows.item(0).catagory);
                                $('#txtSpeakerWebFav').val(results.rows.item(0).website);
                                $('#txtSpeakerBioFav').val(results.rows.item(0).biography);
                                var aTag = document.getElementById('speakerfacebooklinkfav');
                                aTag.setAttribute('href', "http://" + results.rows.item(0).facebook.toString());
                                var aTag1 = document.getElementById('speakertwitterlinkfav');
                                aTag1.setAttribute('href', "http://" + results.rows.item(0).twitter.toString());
                                var aTag2 = document.getElementById('speakerlinkedinlinkfav');
                                aTag2.setAttribute('href', "http://" + results.rows.item(0).linkedin.toString());

                                var node = document.getElementById("SpeakerLink2");
                                node.innerHTML = "<div Class='rounded-corners'> <a href='http://" + results.rows.item(0).website + "' >" + results.rows.item(0).website + "</a> </div></br>";
                            }
                        }
                    });
                }
                );
            getSpeakerToSessionListLoadedFav(ID);
        }
        function getSpeakerToSessionListLoadedFav(ID) {
            db = openDatabase(shortName, version, displayName, maxSize);
            db.transaction(

                function (transaction) {

                    transaction.executeSql('SELECT sessionTitle from tbl_Session inner join tbl_SpeakerToSession on tbl_Session.id = tbl_SpeakerToSession.sessionid where tbl_SpeakerToSession.speakerid = ?', [ID], function (transaction, results) {
                        $('#SpeakerToSessionListfav').empty();
                        if (results.rows.length === 0) {
                            $('#SpeakerToSessionListfav').empty();
                            $('#SpeakerToSessionListfav').listview('refresh');
                        }
                        else {
                            for (i = 0; i < results.rows.length; i++) {
                                renderTodoSpeakerToSession(results.rows.item(i));
                            }
                        }
                    });


                }

             );
        }



        function getPersonnalFavoriteCounts() {
            try {
                db = openDatabase(shortName, version, displayName, maxSize);
                db.transaction(
                    function (transaction) {
                        transaction.executeSql('SELECT count(*) as cnt from tbl_session inner join tbl_FavoriteSession on tbl_FavoriteSession.sessionid= tbl_Session.id where tbl_FavoriteSession.flag="true" ', [], function (transaction, results) {
                            var Count1 = results.rows.item(0).cnt;
                            $("#Span4").text(Count1 + "");
                        });
                        transaction.executeSql('select count(*) as cnt from tbl_Speaker inner join tbl_FavoriteSpeaker on tbl_FavoriteSpeaker.speakerid = tbl_Speaker.id where tbl_FavoriteSpeaker.flag="true"', [], function (transaction, results) {
                            var Count2 = results.rows.item(0).cnt;
                            $("#Span3").text(Count2 + "");
                        });
                        transaction.executeSql(' SELECT count(*) as cnt from tbl_Exhibitor inner join tbl_FavoriteExihibitor on tbl_Exhibitor.id = tbl_FavoriteExihibitor.exhiid where tbl_FavoriteExihibitor.flag="true"', [], function (transaction, results) {
                            var Count3 = results.rows.item(0).cnt;
                            $("#Span2").text(Count3 + "");
                        });
                        transaction.executeSql(' SELECT count(*) as cnt  from tbl_Attendee inner join tbl_FavoriteAttendee on tbl_Attendee.Id= tbl_FavoriteAttendee.attendeeid where tbl_FavoriteAttendee.flag="true" ', [], function (transaction, results) {
                            var Count4 = results.rows.item(0).cnt;
                            $("#Span1").text(Count4 + "");
                        });
                        $('#personalScheduleList').listview('refresh');
                    }
                 );

            } catch (e) {
            }
        }

        function getEventEvaluation() {

            $('#EventEvaluationList').empty();
            $('#EventEvaluationList').listview('refresh');
            ecode = localStorage.getItem("EventCode");
            db = openDatabase(shortName, version, displayName, maxSize);
            db.transaction(
                function (transaction) {
                    transaction.executeSql('SELECT * from tbl_QuestionsEvent where event_code=?', [ecode], function (transaction, results) {
                        if (results.rows.length === 0) {
                            $('#EventEvaluationList').empty();
                            $('#EventEvaluationList').listview('refresh');
                        }
                        else {
                            $('#EventEvaluationList').empty();
                            for (i = 0; i < results.rows.length; i++) {
                                if (results.rows.item(i).flag === "true") {
                                    $('#EventEvaluationList').append(
                                    '<li>' +
                                    '<a href="">' +
                                         '<h1>' + results.rows.item(i).questionText + '</h1>' +
                                         '<p>Already Answered... </p>' +
                                    '</li>'
                                );
                                    $('#EventEvaluationList').listview('refresh');
                                }
                                else {
                                    $('#EventEvaluationList').append(
                                    '<li>' +
                                         '<a href="#eventEvalQuestions" onclick=onEventEvalQuestionClick(' + results.rows.item(i).id + ') >' +
                                         '<h1>' + results.rows.item(i).questionText + '</h1>' +
                                         '</a>' +
                                    '</li>'

                                   );
                                    $('#questiontoshow').text(results.rows.item(i).questionText);
                                    $('#eevalquestionid').val(results.rows.item(i).id);
                                    $('#EventEvaluationList').listview('refresh');
                                }
                            }
                        }
                    });
                }
             );
        }
        function onEventEvalQuestionClick(ID) {


            db = openDatabase(shortName, version, displayName, maxSize);
            db.transaction(
                function (transaction) {
                    transaction.executeSql('SELECT * from tbl_QuestionsEvent where id=?', [ID], function (transaction, results) {
                        for (i = 0; i < results.rows.length; i++) {
                            $('#questiontoshow').text(results.rows.item(i).questionText);
                            $('#eevalquestionid').val(results.rows.item(i).id);
                        }
                    });
                });
        }
        function saveEventEval(eequestionID) {
            var questionid = eequestionID;
            var attendeeId = localStorage.getItem("AttendeeId");
            var answervalue = 0;
            var radio_val = $('input[name="radio-view"]:checked').val();
            if (typeof (radio_val) != "undefined") {
                answervalue = radio_val;
                db = openDatabase(shortName, version, displayName, maxSize);
                db.transaction(
                    function (transaction) {
                        transaction.executeSql('insert into tbl_QuestionAnswers(questionId,event_code,attendeeid,optionid) values(?,?,?,?)', [parseInt(questionid), ecode, parseInt(attendeeId), parseInt(answervalue)], function (transaction, results) {
                            $.mobile.changePage("#EventEvaluation");
                        });
                    }
                 );
                db = openDatabase(shortName, version, displayName, maxSize);
                db.transaction(
                    function (transaction) {
                        transaction.executeSql('update tbl_QuestionsEvent set flag="true" where id=?', [questionid], function (transaction, results) {
                        });
                    }
                 );
            }


            $().toastmessage('showToast', {
                text: 'Thanks for your feedback',
                sticky: false,
                position: 'top-right',
                type: 'success',
                closeText: '',
                close: function () {
                }
            });
            getEventEvaluation();

        }
        function getSession() {
            $('#SessionList').empty();

            db = openDatabase(shortName, version, displayName, maxSize);
            db.transaction(
                function (transaction) {
                    ecode = localStorage.getItem("EventCode");
                    transaction.executeSql('select tbl_Speaker.firstname,tbl_Speaker.lastname, tbl_Session.id ,tbl_Session.event_code,tbl_Session.sessionTitle, tbl_Session.sessionDate,tbl_Session.sessionStartTime,tbl_Session.sessionFinishTime ,tbl_Session.sessionLocation,tbl_Session.overview,tbl_Session.sessionSpeakerFname,tbl_FavoriteSession.ucode , tbl_FavoriteSession.sessionid,tbl_FavoriteSession.flag from tbl_Speaker inner join tbl_SpeakerToSession on tbl_SpeakerToSession.speakerid = tbl_Speaker.id inner join tbl_Session on tbl_SpeakerToSession.sessionid = tbl_Session.id left outer join tbl_FavoriteSession on tbl_Session.id = tbl_FavoriteSession.sessionid where tbl_Session.event_code=?', [ecode], function (transaction, results) {
                        $('#SessionList').empty();

                        if (results.rows.length === 0) {
                            $('#SessionList').empty();
                            $('#SessionList').listview('refresh');
                        }
                        else {
                            for (i = 0; i < results.rows.length; i++) {
                                renderTodoSession(results.rows.item(i));
                            }
                        }
                    });
                }
             );
        }

        function renderTodoSession(row) {
            try {
                var ID, SessionName, SessionLocation, SessionStartTime, SessionEndTime, SessionDate, SpeakerFirstName, SpeakerlastName, Flag;

                if (row.id === null || row.id === "" || row.id === "Undefined")
                { ID = ""; }
                else
                { ID = row.id; }
                if (row.sessionDate === null || row.sessionDate === "" || row.sessionDate === "Undefined")
                { SessionDate = ""; }
                else
                { SessionDate = row.sessionDate; }
                var datepartSession = SessionDate.split(" ");
                if (row.sessionTitle === null || row.sessionTitle === "" || row.sessionTitle === "Undefined")
                { SessionName = ""; }
                else
                { SessionName = row.sessionTitle; }
                if (row.sessionLocation === null || row.sessionLocation === "" || row.sessionLocation === "Undefined")
                { SessionLocation = ""; }
                else
                { SessionLocation = row.sessionLocation; }
                if (row.sessionStartTime === null || row.sessionStartTime === "" || row.sessionStartTime === "Undefined")
                { SessionStartTime = ""; }
                else
                { SessionStartTime = row.sessionStartTime; }
                if (row.sessionFinishTime === null || row.sessionFinishTime === "" || row.sessionFinishTime === "Undefined")
                { SessionEndTime = ""; }
                else
                { SessionEndTime = row.sessionFinishTime; }

                if (row.flag === null || row.flag === "" || row.flag === "Undefined" || row.flag === "false")
                { Flag = ""; }
                else
                { Flag = row.flag; }
                if (row.firstname === null || row.firstname === "" || row.firstname === "Undefined" || row.firstname === "false")
                { SpeakerFirstName = ""; }
                else
                { SpeakerFirstName = row.firstname; }
                if (row.lastname === null || row.lastname === "" || row.lastname === "Undefined" || row.lastname === "false")
                { SpeakerlastName = ""; }
                else
                { SpeakerlastName = row.lastname; }


                if (Flag === "") {
                    $('#SessionList').append(
                          '<li>' +
                                  '<a href="#sessionDetails"    onclick="getClickSession(' + ID + ')">' +
                                    '<h3 class="ui-li-heading">' + SessionName + '</h3>' +
                                    '<p class="ui-li-desc">' + SpeakerFirstName + ' ' + SpeakerlastName + '</p>' +
                                    '<p class="ui-li-desc">' + SessionLocation + '</p>' +
                                     '<p class="ui-li-desc">' + datepartSession[0] + '</p>' +
                                    '<p class="ui-li-desc">' + SessionStartTime + ' To ' + SessionEndTime + '</p></a>' +
                           '</li>'
                     );
                }
                else {
                    $('#SessionList').append(
                       '<li>' +
                              '<a href="#sessionDetails"    onclick="getClickSession(' + ID + ')">' +
                                    '<h3 class="ui-li-heading">' + SessionName + '</h3>' +
                                    '<p class="ui-li-desc">' + SpeakerFirstName + ' ' + SpeakerlastName + '</p>' +
                                    '<p class="ui-li-desc">' + SessionLocation + '</p>' +
                                    '<p class="ui-li-desc">' + SessionStartTime + ' To ' + SessionEndTime + '</p>' +
                                      '<p class="ui-li-desc">' + datepartSession[0] + '</p>' +
                                 '<span class="ui-li-count" style="border:0px; font-size:18px"><a href="#" style="padding:0px; margin:0px; border:0px; background:round" data-role="button" data-icon="star" data-iconpos="notext">star</a></span></span>' +
                             '</a> ' +
                      '</li>'
                      );
                }
                $('#SessionList').listview('refresh');
            } catch (e) {
            }
        }
        function getSessionNoteLoaded(ID) {
        }

        function getClickSession(ID) {
            db = openDatabase(shortName, version, displayName, maxSize);
            db.transaction(
                function (transaction) {
                    transaction.executeSql('select tbl_Speaker.firstname, tbl_Session.id ,tbl_Session.event_code,tbl_Session.sessionTitle, tbl_Session.sessionDate,tbl_Session.sessionStartTime,tbl_Session.sessionFinishTime ,tbl_Session.sessionLocation,tbl_Session.overview,tbl_Session.sessionSpeakerFname,tbl_FavoriteSession.ucode , tbl_FavoriteSession.sessionid,tbl_FavoriteSession.flag from tbl_Speaker inner join tbl_SpeakerToSession on tbl_SpeakerToSession.speakerid = tbl_Speaker.id inner join tbl_Session on tbl_SpeakerToSession.sessionid = tbl_Session.id left outer join tbl_FavoriteSession on tbl_Session.id = tbl_FavoriteSession.sessionid where tbl_Session.id=?', [ID], function (transaction, results) {
                        if (results.rows.length != 0) {
                            var name = results.rows.item(0).sessionTitle;
                            var speakername = results.rows.item(0).firstname;// + ' ' + results.rows.item(0).lastname;
                            localStorage.setItem("sessionDetailId", ID);
                            $('#sessionhiddenid').val(ID);
                            $('#txtSessionName').val(name);
                            $('#txtSessionLocation').val(results.rows.item(0).sessionLocation);
                            $('#txtsessionfinishtime').val(results.rows.item(0).sessionFinishTime);
                            $('#txtsessionSpeaker').val(speakername);
                            $('#txtsessionstarttime').val(results.rows.item(0).sessionStartTime);
                            var datepartSession = results.rows.item(0).sessionDate.split(" ");
                            $('#txtsessionDate').val(datepartSession[0]);
                            $('#txtSessionOverview').val(results.rows.item(0).overview);
                            $('#txtSessionNote').val(results.rows.item(0).note);
                            getSessionNoteLoaded(ID);
                        }
                    });
                }
             );
        }


        function initializeMap(lat, lon) {
            directionsDisplay = new google.maps.DirectionsRenderer();
            directionsService = new google.maps.DirectionsService();
            currentPosition = new google.maps.LatLng(lat, lon);
            map = new google.maps.Map(document.getElementById('map_canvas'), {
                zoom: 15,
                center: currentPosition,
                mapTypeId: google.maps.MapTypeId.ROADMAP
            });
            directionsDisplay.setMap(map);
            var currentPositionMarker = new google.maps.Marker({
                position: currentPosition,
                map: map,
                title: "Current position"
            });
            var Address;
            var latlng = new google.maps.LatLng(lat, lon);
            geocoder = new google.maps.Geocoder();
            geocoder.geocode({
                'latLng': latlng
            }, function (results, status) {
                Address = (results[0].formatted_address);
                console.log(results);
            });
            var infowindow = new google.maps.InfoWindow();
            google.maps.event.addListener(currentPositionMarker, 'click', function () {
                infowindow.setContent("Current position: latitude: " + lat + " longitude: " + lon + " <br /> " + " Current place:" + Address);
                infowindow.open(map, currentPositionMarker);
            });
        }
        function locError(error) {
            console.log(error);
        }
        function locSuccess(position) {
            initializeMap(position.coords.latitude, position.coords.longitude);
        }
        function calculateRoute() {
            var targetDestination = $("#target-dest").val();
            if (currentPosition && currentPosition != '' && targetDestination && targetDestination != '') {
                var request = {
                    origin: currentPosition,
                    destination: targetDestination,
                    travelMode: google.maps.DirectionsTravelMode["DRIVING"]
                };
                directionsService.route(request, function (response, status) {
                    if (status == google.maps.DirectionsStatus.OK) {
                        directionsDisplay.setPanel(document.getElementById("directions"));
                        directionsDisplay.setDirections(response);
                        $("#results").show();
                    }
                    else {
                        $("#results").hide();
                    }
                });
            }
            else {
                $("#results").hide();
            }
        }
        function getMap() {
            try {
                db = openDatabase(shortName, version, displayName, maxSize);
                db.transaction(

                    function (transaction) {
                        ecode = localStorage.getItem("EventCode");
                        transaction.executeSql('SELECT * FROM tbl_Event where event_code=?', [ecode], function (transaction, results) {
                            renderEventMap(results.rows.item(0));
                            // alert(results.rows.item(0).latitude + "" + results.rows.item(0).longitude);
                        });
                    }
                 );
            } catch (e) {
            }
        }

        function renderEventMap(row) {
            try {
                initializeMap(row.latitude, row.longitude);
                $("#MainMapImageLink").attr("href", "imagesMap/" + row.event_code + "1" + row.MIMEtype);
                $("#MainMapImageLink1").attr("href", "imagesMap/" + row.event_code + "2" + row.MIMEtype);
                $("#MainMapImageLink2").attr("href", "imagesMap/" + row.event_code + "3" + row.MIMEtype);
                $("#MainMapImageLink3").attr("href", "imagesMap/" + row.event_code + "4" + row.MIMEtype);
                $("#MainMapImageLink4").attr("href", "imagesMap/" + row.event_code + "5" + row.MIMEtype);
                document.getElementById('map').style.backgroundColor = "black";
                document.getElementById('maimapimagetag').src = "imagesMap/" + row.event_code + "1" + row.MIMEtype;
                document.getElementById('maimapimagetag1').src = "imagesMap/" + row.event_code + "2" + row.MIMEtype;
                document.getElementById('maimapimagetag2').src = "imagesMap/" + row.event_code + "3" + row.MIMEtype;
                document.getElementById('maimapimagetag3').src = "imagesMap/" + row.event_code + "4" + row.MIMEtype;
                document.getElementById('maimapimagetag4').src = "imagesMap/" + row.event_code + "5" + row.MIMEtype;
                document.getElementById('map1').style.backgroundColor = "black";
                document.getElementById('map2').style.backgroundColor = "black";
                document.getElementById('map3').style.backgroundColor = "black";
                document.getElementById('map4').style.backgroundColor = "black";

            }
            catch (e) {
            }
        }
        function getTwitterLinkUrl() {

            db = openDatabase(shortName, version, displayName, maxSize);
            db.transaction(
                function (transaction) {
                    transaction.executeSql('select tlink,twitterid from tbl_twitter where tbl_twitter.event_code=?', [ecode], function (transaction, results) {
                        if (results.rows.length != 0) {
                            var link = results.rows.item(0).tlink;
                            var aTag2 = document.getElementById('twitterLink');
                            aTag2.setAttribute('href', results.rows.item(0).tlink.toString() + results.rows.item(0).twitterid.toString());
                        }
                    });
                }
             );
        }
        function getProfile() {
            try {
                db = openDatabase(shortName, version, displayName, maxSize);
                db.transaction(
                    function (transaction) {
                        var usertype = localStorage.getItem("UserType");
                        if (usertype == 1) {
                            transaction.executeSql('select tbl_Attendee.id,tbl_Attendee.event_code,tbl_Attendee.Attendee_Level,tbl_Attendee.Title, tbl_Attendee.Firstname, tbl_Attendee.Lastname,tbl_Attendee.Position,tbl_Attendee.Category_Industry,tbl_Attendee.Address,tbl_Attendee.Phone_Number,tbl_Attendee.Email,tbl_Attendee.Biography,tbl_Attendee.Website,tbl_Attendee.company,tbl_Attendee.MIMEtype,tbl_Attendee.checkin,tbl_Attendee.offlineUpdate,tbl_Attendee.adminlink FROM tbl_Attendee  where event_code=? and id=?', [ecode, AttendeeId], function (transaction, results) {
                                for (i = 0; i < results.rows.length; i++) {
                                    loadProfile(results.rows.item(i), usertype);
                                }
                            });
                        }
                        else if (usertype == 2) {
                            transaction.executeSql('select tbl_Exhibitor.id,tbl_Exhibitor.event_code,tbl_Exhibitor.standno,tbl_Exhibitor.contactname,tbl_Exhibitor.position,tbl_Exhibitor.catagory,tbl_Exhibitor.address,tbl_Exhibitor.phoneno,tbl_Exhibitor.email,tbl_Exhibitor.biography,tbl_Exhibitor.website,tbl_Exhibitor.company,tbl_Exhibitor.MIMEtype FROM tbl_Exhibitor  where event_code=? and id=?', [ecode, AttendeeId], function (transaction, results) {
                                for (i = 0; i < results.rows.length; i++) {
                                    loadProfile(results.rows.item(i), usertype);
                                }
                            });
                        }
                        else if (usertype == 3) {
                            transaction.executeSql('select tbl_Speaker.id,tbl_Speaker.event_code,tbl_Speaker.title, tbl_Speaker.firstname, tbl_Speaker.lastname,tbl_Speaker.position,tbl_Speaker.categoryIndustry,tbl_Speaker.address,tbl_Speaker.phoneno,tbl_Speaker.email,tbl_Speaker.biography,tbl_Speaker.website,tbl_Speaker.company,tbl_Speaker.MIMEtype FROM tbl_Speaker  where event_code=? and id=?', [ecode, AttendeeId], function (transaction, results) {
                                for (i = 0; i < results.rows.length; i++) {
                                    loadProfile(results.rows.item(i), usertype);
                                }
                            });
                        }
                        else if (usertype == 4) {
                            transaction.executeSql('select tbl_Sponsor.id,tbl_Sponsor.event_code,tbl_Sponsor.sponsorname, tbl_Sponsor.contactname, tbl_Sponsor.position,tbl_Sponsor.address,tbl_Sponsor.phone,tbl_Sponsor.email,tbl_Sponsor.discription,tbl_Sponsor.MIMEtype FROM tbl_Sponsor  where event_code=? and id=?', [ecode, AttendeeId], function (transaction, results) {
                                for (i = 0; i < results.rows.length; i++) {
                                    loadProfile(results.rows.item(i), usertype);
                                }
                            });
                        }
                    }
                 );
            } catch (e) {
            }
        }
        function loadProfile(row, usertype) {
            try {
                var ID, Contactname, MainName, StandNo, Title, Firstname, Lastname, Position, Company, Phone, Website, Category_Industry, Address, Email, Biography, MIMEtype, Checkin, Flag, AdminLink;
                if (usertype == "1") {


                    if (row.id === null || row.id === "" || row.id === "Undefined")
                    { ID = ""; }
                    else
                    { ID = row.id; }
                    if (row.MIMEtype === null || row.MIMEtype === "" || row.MIMEtype === "Undefined")
                    { MIMEtype = ""; }
                    else
                    { MIMEtype = row.MIMEtype; }
                    if (row.flag === null || row.flag === "" || row.flag === "Undefined")
                    { Flag = ""; }
                    else
                    { Flag = row.flag; }
                    if (row.Title === null || row.Title === "" || row.Title === "Undefined")
                    { Title = ""; }
                    else
                    { Title = row.Title; }
                    if (row.Firstname === null || row.Firstname === "" || row.Firstname === "Undefined")
                    { Firstname = ""; }
                    else
                    { Firstname = row.Firstname; }
                    if (row.Lastname === null || row.Lastname === "" || row.Lastname === "Undefined")
                    { Lastname = ""; }
                    else
                    { Lastname = row.Lastname; }
                    if (row.Position === null || row.Position === "" || row.Position === "Undefined")
                    { Position = ""; }
                    else
                    { Position = row.Position; }
                    if (row.company === null || row.company === "" || row.company === "Undefined")
                    { Company = ""; }
                    else
                    { Company = row.company; }
                    if (row.Website === null || row.Website === "" || row.Website === "Undefined")
                    { Website = ""; }
                    else
                    { Website = row.Website; }
                    if (row.Category_Industry === null || row.Category_Industry === "" || row.Category_Industry === "Undefined")
                    { Category_Industry = ""; }
                    else
                    { Category_Industry = row.Category_Industry; }
                    if (row.Address === null || row.Address === "" || row.Address === "Undefined")
                    { Address = ""; }
                    else
                    { Address = row.Address; }
                    if (row.Email === null || row.Email === "" || row.Email === "Undefined")
                    { Email = ""; }
                    else
                    { Email = row.Email; }

                    if (row.Biography === null || row.Biography === "" || row.Biography === "Undefined")
                    { Biography = ""; }
                    else
                    { Biography = row.Biography; }
                    if (row.checkin === null || row.checkin === "" || row.checkin === "Undefined")
                    { Checkin = ""; }
                    else
                    { Checkin = row.checkin; }
                    if (row.adminlink === null || row.adminlink === "" || row.adminlink === "Undefined")
                    { AdminLink = ""; }
                    else
                    { AdminLink = row.adminlink; }
                    document.getElementById('profileImage').src = 'imagesattaindee/' + ID + MIMEtype;
                    $('#NameDiv').hide();
                    $('#contactNameDiv').hide();
                    $('#nameTitleDiv').show();
                    $('#fnameDiv').show();
                    $('#lnamediv').show();
                    $('#txtEmailaddress').val(Email);
                    $('#txttitle').val(Title);
                    $('#txtfname').val(Firstname);
                    $('#txtlname').val(Lastname);
                    $('#txtposition').val(Position);
                    $('#txtCompany').val(Company);
                    $('#txtAddress').val(Address);
                    $('#txtPhone').val(row.Phone_Number);
                    $('#txtpCategory').val(Category_Industry);
                    $('#txtbio').val(Biography);
                    var node = document.getElementById("txtwebsite");
                    node.innerHTML = "<div Class='rounded-corners' > <a href='http://" + Website + "' target='_blank'>" + Website + "</a>  </div></br>";
                    var node = document.getElementById("txtAdminProfile");
                    node.innerHTML = "<div Class='rounded-corners' style='color:Blue;'> <a  id='CmsLink' href='[[url]]' target='_blank'>Click Here To Edit Your Profile</a> </div></br>";
                    $("#CmsLink").attr("href", AdminLink);
                }
                if (usertype == "2") {
                    if (row.id === null || row.id === "" || row.id === "Undefined")
                    { ID = ""; }
                    else
                    { ID = row.id; }
                    if (row.MIMEtype === null || row.MIMEtype === "" || row.MIMEtype === "Undefined")
                    { MIMEtype = ""; }
                    else
                    { MIMEtype = row.MIMEtype; }
                    if (row.standno === null || row.standno === "" || row.standno === "Undefined")
                    { StandNo = ""; }
                    else
                    { StandNo = row.standno; }
                    if (row.contactname === null || row.contactname === "" || row.contactname === "Undefined")
                    { Contactname = ""; }
                    else
                    { Contactname = row.contactname; }
                    if (row.position === null || row.position === "" || row.position === "Undefined")
                    { Position = ""; }
                    else
                    { Position = row.position; }
                    if (row.catagory === null || row.catagory === "" || row.catagory === "Undefined")
                    { Category_Industry = ""; }
                    else
                    { Category_Industry = row.catagory; }
                    if (row.address === null || row.address === "" || row.address === "Undefined")
                    { Address = ""; }
                    else
                    { Address = row.address; }
                    if (row.company === null || row.company === "" || row.company === "Undefined")
                    { Company = ""; }
                    else
                    { Company = row.company; }
                    if (row.website === null || row.website === "" || row.website === "Undefined")
                    { Website = ""; }
                    else
                    { Website = row.website; }
                    if (row.phoneno === null || row.phoneno === "" || row.phoneno === "Undefined")
                    { Phone = ""; }
                    else
                    { Phone = row.phoneno; }
                    if (row.Address === null || row.Address === "" || row.Address === "Undefined")
                    { Address = ""; }
                    else
                    { Address = row.Address; }
                    if (row.email === null || row.email === "" || row.email === "Undefined")
                    { Email = ""; }
                    else
                    { Email = row.email; }
                    if (row.biography === null || row.biography === "" || row.biography === "Undefined")
                    { Biography = ""; }
                    else
                    { Biography = row.biography; }
                    if (row.adminlink === null || row.adminlink === "" || row.adminlink === "Undefined")
                    { AdminLink = ""; }
                    else
                    { AdminLink = row.adminlink; }
                    document.getElementById('profileImage').src = 'imagesExihibitor/' + ID + MIMEtype;
                    $('#txtEmailaddress').val(Email);
                    $('#txtContactName').val(Contactname);
                    $('#txtposition').val(Position);
                    $('#txtmpstandno').val(StandNo);
                    $('#txtCompany').val(Company);
                    $('#txtAddress').val(Address);
                    $('#txtPhone').val(Phone);
                    $('#txtpCategory').val(Category_Industry);
                    $('#txtbio').val(Biography);
                    $('#NameDiv').show();
                    $('#contactNameDiv').show();
                    $('#nameTitleDiv').hide();
                    $('#fnamediv').hide();
                    $('#lnamediv').hide();

                    var node = document.getElementById("txtwebsite");
                    node.innerHTML = "<div Class='rounded-corners' > <a href='http://" + Website + "' target='_blank'>" + Website + "</a>  </div></br>";
                    var node = document.getElementById("txtAdminProfile");
                    node.innerHTML = "<div Class='rounded-corners' style='color:Blue;'> <a  id='CmsLink' href='[[url]]' target='_blank'>Click Here To Edit Your Profile</a> </div></br>";
                    $("#CmsLink").attr("href", AdminLink);
                }
                if (usertype == "3") {
                    if (row.id === null || row.id === "" || row.id === "Undefined")
                    { ID = ""; }
                    else
                    { ID = row.id; }
                    if (row.MIMEtype === null || row.MIMEtype === "" || row.MIMEtype === "Undefined")
                    { MIMEtype = ""; }
                    else
                    { MIMEtype = row.MIMEtype; }
                    if (row.flag === null || row.flag === "" || row.flag === "Undefined")
                    { Flag = ""; }
                    else
                    { Flag = row.flag; }
                    if (row.title === null || row.title === "" || row.title === "Undefined")
                    { Title = ""; }
                    else
                    { Title = row.title; }
                    if (row.firstname === null || row.firstname === "" || row.firstname === "Undefined")
                    { Firstname = ""; }
                    else
                    { Firstname = row.firstname; }
                    if (row.lastname === null || row.lastname === "" || row.lastname === "Undefined")
                    { Lastname = ""; }
                    else
                    { Lastname = row.lastname; }
                    if (row.position === null || row.position === "" || row.position === "Undefined")
                    { Position = ""; }
                    else
                    { Position = row.position; }
                    if (row.company === null || row.company === "" || row.company === "Undefined")
                    { Company = ""; }
                    else
                    { Company = row.company; }
                    if (row.website === null || row.website === "" || row.website === "Undefined")
                    { Website = ""; }
                    else
                    { Website = row.website; }
                    if (row.categoryIndustry === null || row.categoryIndustry === "" || row.categoryIndustry === "Undefined")
                    { Category_Industry = ""; }
                    else
                    { Category_Industry = row.categoryIndustry; }
                    if (row.Address === null || row.Address === "" || row.Address === "Undefined")
                    { Address = ""; }
                    else
                    { Address = row.Address; }
                    if (row.email === null || row.email === "" || row.email === "Undefined")
                    { Email = ""; }
                    else
                    { Email = row.email; }
                    if (row.phoneno === null || row.phoneno === "" || row.phoneno === "Undefined")
                    { Phone = ""; }
                    else
                    { Phone = row.phoneno; }
                    if (row.biography === null || row.biography === "" || row.biography === "Undefined")
                    { Biography = ""; }
                    else
                    { Biography = row.biography; }
                    if (row.adminlink === null || row.adminlink === "" || row.adminlink === "Undefined")
                    { AdminLink = ""; }
                    else
                    { AdminLink = row.adminlink; }
                    document.getElementById('profileImage').src = 'imagesSpeaker/' + ID + MIMEtype;
                    $('#NameDiv').hide();
                    $('#contactNameDiv').hide();
                    $('#txtEmailaddress').val(Email);
                    $('#txttitle').val(Title);
                    $('#txtfname').val(Firstname);
                    $('#txtlname').val(Lastname);
                    $('#txtposition').val(Position);
                    $('#txtCompany').val(Company);
                    $('#txtAddress').val(Address);
                    $('#txtPhone').val(Phone);
                    $('#txtpCategory').val(Category_Industry);
                    $('#txtbio').val(Biography);
                    $('#nameTitleDiv').show();
                    $('#fnameDiv').show();
                    $('#lnamediv').show();
                    var node = document.getElementById("txtwebsite");
                    node.innerHTML = "<div Class='rounded-corners' > <a href='http://" + Website + "' target='_blank'>" + Website + "</a>  </div></br>";
                    var node = document.getElementById("txtAdminProfile");
                    node.innerHTML = "<div Class='rounded-corners' style='color:Blue;'> <a  id='CmsLink' href='[[url]]' target='_blank'>Click Here To Edit Your Profile</a> </div></br>";
                    $("#CmsLink").attr("href", AdminLink);
                }
                if (usertype == "4") {
                    if (row.id === null || row.id === "" || row.id === "Undefined")
                    { ID = ""; }
                    else
                    { ID = row.id; }
                    if (row.MIMEtype === null || row.MIMEtype === "" || row.MIMEtype === "Undefined")
                    { MIMEtype = ""; }
                    else
                    { MIMEtype = row.MIMEtype; }
                    if (row.sponsorname === null || row.sponsorname === "" || row.sponsorname === "Undefined")
                    { MainName = ""; }
                    else
                    { MainName = row.sponsorname; }
                    if (row.contactname === null || row.contactname === "" || row.contactname === "Undefined")
                    { Contactname = ""; }
                    else
                    { Contactname = row.contactname; }
                    if (row.phoneno === null || row.phoneno === "" || row.phoneno === "Undefined")
                    { Phone = ""; }
                    else
                    { Phone = row.phoneno; }
                    if (row.position === null || row.position === "" || row.position === "Undefined")
                    { Position = ""; }
                    else
                    { Position = row.position; }
                    if (row.company === null || row.company === "" || row.company === "Undefined")
                    { Company = ""; }
                    else
                    { Company = row.company; }

                    if (row.address === null || row.address === "" || row.address === "Undefined")
                    { Address = ""; }
                    else
                    { Address = row.address; }

                    if (row.email === null || row.email === "" || row.email === "Undefined")
                    { Email = ""; }
                    else
                    { Email = row.email; }

                    if (row.discription === null || row.discription === "" || row.discription === "Undefined")
                    { Biography = ""; }
                    else
                    { Biography = row.discription; }
                    if (row.adminlink === null || row.adminlink === "" || row.adminlink === "Undefined")
                    { AdminLink = ""; }
                    else
                    { AdminLink = row.adminlink; }
                    document.getElementById('profileImage').src = 'imagesSponsor/' + ID + MIMEtype;
                    $('#NameDiv').show();
                    $('#contactNameDiv').show();
                    $('#txtEmailaddress').val(Email);
                    $('#txtMainName').val(MainName);
                    $('#txtContactName').val(Contactname);
                    $('#txtposition').val(Position);
                    $('#txtCompany').val(Company);
                    $('#txtAddress').val(Address);
                    $('#txtPhone').val(Phone);
                    $('#txtbio').val(Biography);
                    $('#nameTitleDiv').hide();
                    $('#fnameDiv').hide();
                    $('#lnamediv').hide();
                    var node = document.getElementById("txtwebsite");
                    node.innerHTML = "<div Class='rounded-corners' > <a href='http://" + Website + "' target='_blank'>" + Website + "</a>  </div></br>";
                    var node = document.getElementById("txtAdminProfile");
                    node.innerHTML = "<div Class='rounded-corners' style='color:Blue;'> <a  id='CmsLink' href='[[url]]' target='_blank'>Click Here To Edit Your Profile</a> </div></br>";
                    $("#CmsLink").attr("href", AdminLink);
                }
            } catch (e) {
            }
        }

        function saveOffline() {
            try {
                var aid = AttendeeId;
                var Title = $('#txttitle').val();
                var Firstname = $('#txtfname').val();
                var Lastname = $('#txtlname').val();
                var Position = $('#txtposition').val();
                var Company = $('#txtCompany').val();
                var Address = $('#txtAddress').val();
                var Phone_Number = $('#txtPhone').val();
                var Category = $('#txtpCategory').val();
                var Email = $('#txtEmailaddress').val();
                var Website = $('#txtwebsite').val();
                var biography = $('#txtbio').val();

                //if (navigator.onLine) {
                PageMethods.UpdateProfile(aid, Title, Firstname, Position, Company, Address, Phone_Number, Category, Email, Website, biography, file);
                //}
                //else {
                //    db = openDatabase(shortName, version, displayName, maxSize);
                //    db.transaction(
                //        function (transaction) {
                //            transaction.executeSql('update tbl_Attendee set Title=?,Firstname=?,Lastname=?,Position=?,company=?,Category_Industry=?,Address=?,Phone_Number=?,Email=?,Website=?,offlineUpdate="YES",Biography=? where id =?',
                //                [Title, Firstname, Lastname, Position, Company, Category, Address, Phone_Number, Email, Website, biography, parseInt(aid)]);
                //        });
                //}
            } catch (e) {
                console.log(e.message);
            }
        }


        function getSpeaker() {
            db = openDatabase(shortName, version, displayName, maxSize);
            $('#speakerlist').empty();
            db.transaction(
                function (transaction) {
                    ecode = localStorage.getItem("EventCode");
                    transaction.executeSql('select tbl_FavoriteSpeaker.ucode, tbl_FavoriteSpeaker.speakerid,tbl_FavoriteSpeaker.flag, tbl_Speaker.id ,tbl_Speaker.event_code ,tbl_Speaker.title , tbl_Speaker.firstname, tbl_Speaker.lastname,tbl_Speaker.position ,tbl_Speaker.categoryIndustry,tbl_Speaker.company ,tbl_Speaker.address ,tbl_Speaker.phoneno ,tbl_Speaker.email ,tbl_Speaker.website,tbl_Speaker.biography,tbl_Speaker.MIMEtype from tbl_Speaker left outer join tbl_FavoriteSpeaker on tbl_Speaker.id = tbl_FavoriteSpeaker.speakerid where tbl_Speaker.event_code=?', [ecode], function (transaction, results) {
                        $('#speakerlist').empty();
                        if (results.rows.length === 0) {
                            $('#speakerlist').empty();
                            $('#speakerlist').listview('refresh');
                        }
                        else {
                            for (i = 0; i < results.rows.length; i++) {
                                renderTodoSpeakers(results.rows.item(i));
                            }
                        }
                    });
                }
             );
        }
        function renderTodoSpeakers(row) {

            try {
                var ID, Title, Firstname, Lastname, Position, Company, Website, Category_Industry, Address, Email, Biography, MIMEtype, Flag;
                if (row.id === null || row.id === "" || row.id == "undefined")
                { ID = ""; }
                else
                { ID = row.id; }
                if (row.MIMEtype === null || row.MIMEtype === "" || row.MIMEtype == "undefined")
                { MIMEtype = ""; }
                else
                { MIMEtype = row.MIMEtype; }
                if (row.title === null || row.title === "" || row.title == "undefined")
                { title = ""; }
                else
                { Title = row.title; }
                if (row.firstname === null || row.firstname === "" || row.firstname === "undefined")
                { Firstname = ""; }
                else
                { Firstname = row.firstname; }
                if (row.lastname === null || row.lastname === "" || row.lastname === "undefined")
                { Lastname = ""; }
                else
                { Lastname = row.lastname; }
                if (row.position === null || row.position === "" || row.position === "undefined")
                { Position = ""; }
                else
                { Position = row.position; }
                if (row.company === null || row.company === "" || row.company === "undefined")
                { Company = ""; }
                else
                { Company = row.company; }
                if (row.website === null || row.website === "" || row.website === "undefined")
                { Website = ""; }
                else
                { Website = row.website; }
                if (row.categoryindustry === null || row.categoryindustry === "" || row.categoryindustry === "undefined")
                { Category_Industry = ""; }
                else
                { Category_Industry = row.categoryindustry; }
                if (row.address === null || row.address === "" || row.address === "undefined")
                { Address = ""; }
                else
                { Address = row.address; }
                if (row.email === null || row.email === "" || row.email === "undefined")
                { Email = ""; }
                else
                { Email = row.email; }
                if (row.biography === null || row.biography === "" || row.biography === "undefined")
                { Biography = ""; }
                else
                { Biography = row.biography; }
                if (row.flag === null || row.flag === "" || row.flag === "Undefined" || row.flag === "false")
                { Flag = ""; }
                else
                { Flag = row.flag; }
                if (Flag === "") {
                    $('#speakerlist').append(
                    '<li class="listex">' +
                          '<a href="#SpeakerDetails"   onclick="getClickSpeaker(' + ID + ');"><img src="imagesSpeaker/' + ID + MIMEtype + '" class="ui-li-thumb" border="0" />' +
                              '<h3 class="ui-li-heading">' + Title + " " + Firstname + " " + Lastname + '</h3>' +
                              '<p class="ui-li-desc">' + Position + '</p>' +
                              '<p class="ui-li-desc">' + Company + '</p>' +
                          '</a> ' +
                   '</li>'
                    );
                    $('#speakerlist').listview('refresh');
                }
                else {
                    $('#speakerlist').append(
                    '<li>' +
                          '<a href="#SpeakerDetails"    onclick="getClickSpeaker(' + ID + ');"><img src="imagesSpeaker/' + ID + MIMEtype + '" class="ui-li-thumb" border="0" />' +
                              '<h3 class="ui-li-heading">' + Title + " " + Firstname + " " + Lastname + '</h3>' +
                              '<p class="ui-li-desc">' + Position + '</p>' +
                              '<p class="ui-li-desc">' + Company + '</p>' +
                              '<span class="ui-li-count" style="border:0px; font-size:18px"><a href="#" style="padding:0px; margin:0px; border:0px; background:round" data-role="button" data-icon="star" data-iconpos="notext">star</a></span></span>' +
                          '</a> ' +
                   '</li>'
                     );
                    $('#speakerlist').listview('refresh');
                }
            } catch (e) {
            }

        }

        function getClickSpeaker(ID) {
            db = openDatabase(shortName, version, displayName, maxSize);
            db.transaction(
                function (transaction) {
                    transaction.executeSql('select  tbl_Speaker.id ,tbl_Speaker.facebook,tbl_Speaker.twitter,tbl_Speaker.linkedin,tbl_Speaker.event_code ,tbl_Speaker.title , tbl_Speaker.firstname,tbl_Speaker.lastname,tbl_Speaker.position ,tbl_Speaker.categoryIndustry,tbl_Speaker.company ,tbl_Speaker.address ,tbl_Speaker.phoneno ,tbl_Speaker.email ,tbl_Speaker.website,tbl_Speaker.biography,tbl_Speaker.MIMEtype from tbl_Speaker where tbl_Speaker.id = ?', [ID], function (transaction, results) {

                        if (results.rows.length === 0) {
                            $('#speakerlist').empty();
                        }
                        else {
                            for (i = 0; i < results.rows.length; i++) {
                                renderTodo(results.rows.item(0));
                                document.getElementById('SpeakerImage').src = 'imagesSpeaker/' + results.rows.item(0).id + results.rows.item(0).MIMEtype;
                                var name = results.rows.item(0).title + ' ' + results.rows.item(0).firstname + ' ' + results.rows.item(0).lastname;
                                localStorage.setItem("SpeakerDetailsID", ID);
                                $('#speakerhiddenid').val(ID);
                                $('#senderType3').val(3);
                                $('#toSpeakerId').val(ID);
                                $('#txtSpeakerName').val(name);
                                $('#messageToSpeakerHead').html('Message to <br />' + name);
                                localStorage.setItem("ReceiverName", name);
                                $('#txtSpeakerComp').val(results.rows.item(0).company);
                                $('#txtSpeakerCat').val(results.rows.item(0).catagory);
                                $('#txtSpeakerBio').val(results.rows.item(0).biography);
                                $('#txtSpeakerposition').val(results.rows.item(0).position);
                                $('#txtSpeakeremail').val(results.rows.item(0).email);
                                $('#txtSpeakerphone').val(results.rows.item(0).phoneno);
                                $('#txtSpeakeraddress').val(results.rows.item(0).address);
                                var aTag = document.getElementById('speakerfacebooklink');
                                aTag.setAttribute('href', "http://" + results.rows.item(0).facebook.toString());
                                var aTag1 = document.getElementById('speakertwitterlink');
                                aTag1.setAttribute('href', "http://" + results.rows.item(0).twitter.toString());
                                var aTag2 = document.getElementById('speakerlinkedinlink');
                                aTag2.setAttribute('href', "http://" + results.rows.item(0).linkedin.toString());
                                var node = document.getElementById("SpeakerLink1");
                                node.innerHTML = "<div Class='rounded-corners'> <a href='http://" + results.rows.item(0).website + "' >" + results.rows.item(0).website + "</a> </div></br>";
                            }
                        }
                    });
                }
             );
            getSpeakerToSessionListLoaded(ID);
        }

        function getSpeakerToSessionListLoadedFav(ID) {
            db = openDatabase(shortName, version, displayName, maxSize);
            db.transaction(

                function (transaction) {
                    transaction.executeSql('SELECT sessionTitle from tbl_Session inner join tbl_SpeakerToSession on tbl_Session.id = tbl_SpeakerToSession.sessionid where tbl_SpeakerToSession.speakerid = ?', [ID], function (transaction, results) {
                        $('#SpeakerToSessionListFav').empty();
                        if (results.rows.length === 0) {
                            $('#SpeakerToSessionListFav').empty();
                            $('#SpeakerToSessionListFav').listview('refresh');
                        }
                        else {
                            for (i = 0; i < results.rows.length; i++) {
                                renderTodoSpeakerToSession(results.rows.item(i));
                            }
                        }
                    });
                }
             );
        }

        function getSpeakerToSessionListLoaded(ID) {
            db = openDatabase(shortName, version, displayName, maxSize);
            db.transaction(

                function (transaction) {
                    //
                    transaction.executeSql('SELECT tbl_Session.id ,tbl_Session.event_code,tbl_Session.sessionTitle, tbl_Session.sessionDate,tbl_Session.sessionStartTime,tbl_Session.sessionFinishTime ,tbl_Session.sessionLocation,tbl_Session.overview from tbl_Session inner join tbl_SpeakerToSession on tbl_Session.id = tbl_SpeakerToSession.sessionid where tbl_SpeakerToSession.speakerid = ?', [ID], function (transaction, results) {
                        $('#SpeakerToSessionList').empty();
                        if (results.rows.length === 0) {
                            $('#SpeakerToSessionList').empty();
                            $('#SpeakerToSessionList').listview('refresh');
                        }
                        else {
                            for (i = 0; i < results.rows.length; i++) {
                                renderTodoSpeakerToSessionFav(results.rows.item(i));
                            }
                        }
                    });


                }

             );
        }

        function renderTodoSpeakerToSessionFav(row) {
            try {
                var ID, SessionName, SessionLocation, SessionStartTime, SessionEndTime, SessionDate, Flag;

                if (row.id === null || row.id === "" || row.id === "Undefined")
                { ID = ""; }
                else
                { ID = row.id; }

                if (row.sessionDate === null || row.sessionDate === "" || row.sessionDate === "Undefined")
                { SessionDate = ""; }
                else
                { SessionDate = row.sessionDate; }

                var datepartSession = SessionDate.split(" ");

                if (row.sessionTitle === null || row.sessionTitle === "" || row.sessionTitle === "Undefined")
                { SessionName = ""; }
                else
                { SessionName = row.sessionTitle; }
                if (row.sessionLocation === null || row.sessionLocation === "" || row.sessionLocation === "Undefined")
                { SessionLocation = ""; }
                else
                { SessionLocation = row.sessionLocation; }
                if (row.sessionStartTime === null || row.sessionStartTime === "" || row.sessionStartTime === "Undefined")
                { SessionStartTime = ""; }
                else
                { SessionStartTime = row.sessionStartTime; }
                if (row.sessionFinishTime === null || row.sessionFinishTime === "" || row.sessionFinishTime === "Undefined")
                { SessionEndTime = ""; }
                else
                { SessionEndTime = row.sessionFinishTime; }
                $('#SpeakerToSessionList').append(
                      '<li>' +
                              '<a href="#sessionDetails"    onclick="getClickSession(' + ID + ')">' +
                                '<h3 class="ui-li-heading">' + SessionName + '</h3>' +
                                '<p class="ui-li-desc">' + SessionLocation + '</p>' +
                                '<p class="ui-li-desc">' + datepartSession[0] + '</p>' +
                                '<p class="ui-li-desc">' + SessionStartTime + ' To ' + SessionEndTime + '</p></a>' +
                       '</li>'
                 );


                $('#SpeakerToSessionList').listview('refresh');
            } catch (e) {
            }

        }
        function renderTodoSpeakerToSession(row) {


            try {
                var ID, SessionName, SessionLocation, SessionStartTime, SessionEndTime, SessionDate, SpeakerFirstName, SpeakerlastName, Flag;

                if (row.id === null || row.id === "" || row.id === "Undefined")
                { ID = ""; }
                else
                { ID = row.id; }

                if (row.sessionDate === null || row.sessionDate === "" || row.sessionDate === "Undefined")
                { SessionDate = ""; }
                else
                { SessionDate = row.sessionDate; }

                var datepartSession = SessionDate.split(" ");

                if (row.sessionTitle === null || row.sessionTitle === "" || row.sessionTitle === "Undefined")
                { SessionName = ""; }
                else
                { SessionName = row.sessionTitle; }
                if (row.sessionLocation === null || row.sessionLocation === "" || row.sessionLocation === "Undefined")
                { SessionLocation = ""; }
                else
                { SessionLocation = row.sessionLocation; }
                if (row.sessionStartTime === null || row.sessionStartTime === "" || row.sessionStartTime === "Undefined")
                { SessionStartTime = ""; }
                else
                { SessionStartTime = row.sessionStartTime; }
                if (row.sessionFinishTime === null || row.sessionFinishTime === "" || row.sessionFinishTime === "Undefined")
                { SessionEndTime = ""; }
                else
                { SessionEndTime = row.sessionFinishTime; }

                if (row.flag === null || row.flag === "" || row.flag === "Undefined" || row.flag === "false")
                { Flag = ""; }
                else
                { Flag = row.flag; }

                $('#SpeakerToSessionListFav').append(
                        '<li>' +
                                '<a href="#sessionDetails"    onclick="getClickSession(' + ID + ')">' +
                                '<h3 class="ui-li-heading">' + SessionName + '</h3>' +
                                '<p class="ui-li-desc">' + SessionLocation + '</p>' +
                                '<p class="ui-li-desc">' + datepartSession[0] + '</p>' +
                                '<p class="ui-li-desc">' + SessionStartTime + ' To ' + SessionEndTime + '</p></a>' +
                        '</li>'
                    );


                $('#SpeakerToSessionListFav').listview('refresh');
            } catch (e) {
            }
        }
        function getExibitorLoaded() {
            if (navigator.onLine) {
                AttendeeId = localStorage.getItem("AttendeeId");
                PageMethods.GetExhibitorData(AttendeeId, onSucess, onError);
                function onSucess(result) {
                    var tempdb = db;
                    tempdb.transaction(
                        function (transaction) {
                            transaction.executeSql('Delete from tbl_Exhibitor');
                            ProcessExhibitors(result);
                        }
                     );

                }
                function onError(result) {
                }
            }
            else {
            }
        }

        function ProcessExhibitors(result) {

            try {
                for (var i = 0 ; i < result.length; i++) {
                    var _id = result[i]["ID"].toString();
                    var _eventcode = result[i]["EventCode"].toString();
                    var _company = result[i]["Company"].toString();
                    var _standno = result[i]["StandNo"].toString();
                    var _catagory = result[i]["Category"].toString();
                    var _address = result[i]["Address"].toString();
                    var _phoneno = result[i]["Phoneno"].toString();
                    var _email = result[i]["Email"].toString();
                    var _biography = result[i]["Biography"].toString();
                    var _website = result[i]["Website"].toString();
                    var _contactname = result[i]["Contactname"].toString();
                    var _position = result[i]["Position"].toString();
                    var _sponsorshiplevel = result[i]["Sponsorshiplevel"].toString();
                    var _MIMEtype = result[i]["MIMEType"].toString();
                    var _facebook = result[i]["Facebook"].toString();
                    var _twitter = result[i]["Twitter"].toString();
                    var _linkedin = result[i]["LinkedIn"].toString();
                    var _product1 = result[i]["Product1"].toString();
                    var _product2 = result[i]["Product2"].toString();
                    var _product3 = result[i]["Product3"].toString();
                    var _product4 = result[i]["Product4"].toString();
                    var _product5 = result[i]["Product5"].toString();
                    var _MAPMIMEType = result[i]["MAPMIMEType"].toString();
                    console.log(_MAPMIMEType)
                    InsertExhibitorsToWebSql(_id, _eventcode, _company, _standno, _catagory, _address, _phoneno, _email, _biography, _website, _contactname, _position, _sponsorshiplevel, _MIMEtype, _facebook, _twitter, _linkedin, _product1, _product2, _product3, _product4, _product5, _MAPMIMEType);
                }

            } catch (e) {
            }
        }

        function InsertExhibitorsToWebSql(_id, _eventcode, _company, _standno, _catagory, _address, _phoneno, _email, _biography, _website, _contactname, _position, _sponsorshiplevel, _MIMEtype, _facebook, _twitter, _linkedin, _product1, _product2, _product3, _product4, _product5, _MAPMIMEType) {
            var tempdb = db;
            db.transaction(
              function (transaction) {
                  transaction.executeSql('INSERT INTO tbl_Exhibitor(id,event_code,company,standno,catagory,address,phoneno,email,biography,contactname,website,position,sponsorshiplevel,MIMEtype,facebook, twitter, linkedin,product1,product2,product3,product4,product5,MAPMIMEType) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)',
                         [parseInt(_id), _eventcode, _company.toString(), parseInt(_standno), _catagory.toString(), _address.toString(), _phoneno.toString(), _email.toString(), _biography.toString(), _contactname.toString(), _website.toString(), _position.toString(), parseInt(_sponsorshiplevel), _MIMEtype, _facebook.toString(), _twitter.toString(), _linkedin.toString(), _product1.toString(), _product2.toString(), _product3.toString(), _product4.toString(), _product5.toString(), _MAPMIMEType.toString()]);

              }
           );
        }
        function getExihibitor() {

            try {
                $('#exhibitorList').empty();
                db = openDatabase(shortName, version, displayName, maxSize);
                db.transaction(

                    function (transaction) {
                        ecode = localStorage.getItem("EventCode");
                        transaction.executeSql('select tbl_Exhibitor.id,tbl_Exhibitor.event_code,tbl_Exhibitor.company,tbl_Exhibitor.standno,tbl_Exhibitor.MAPMIMEType,tbl_Exhibitor.catagory,tbl_Exhibitor.address,tbl_Exhibitor.phoneno,tbl_Exhibitor.email,tbl_Exhibitor.biography,tbl_Exhibitor.contactname,tbl_Exhibitor.website,tbl_Exhibitor.position, tbl_Exhibitor.sponsorshiplevel, tbl_Exhibitor.MIMEtype, tbl_FavoriteExihibitor.ucode, tbl_FavoriteExihibitor.exhiid, tbl_FavoriteExihibitor.flag from tbl_Exhibitor left outer join tbl_FavoriteExihibitor on tbl_Exhibitor.id = tbl_FavoriteExihibitor.exhiid where tbl_Exhibitor.event_code = ? order by standno', [ecode], function (transaction, results) {
                            $('#exhibitorList').empty();
                            $('#exhibitorList').listview('refresh');
                            if (results.rows.length === 0) {
                                $('#exhibitorList').empty();
                                $('#exhibitorList').listview('refresh');
                            }
                            else {
                                for (i = 0; i < results.rows.length; i++) {
                                    renderTodoExihibitors(results.rows.item(i));
                                }
                            }
                        });
                    }
                 );

            } catch (e) {
            }

        }
        function renderTodoExihibitors(row) {

            try {

                var ID, Contactname, Address, Position, Company, Category, Website, biography, MIMEtype, Flag, Standno, MAPMIMEType;

                ID = row.id;
                MIMEtype = row.MIMEtype;
                Flag = row.flag;
                MAPMIMEType = row.MAPMIMEType;
                if (row.id === null || row.id === "" || row.id === "undefined")
                { ID = ""; }
                else
                { ID = row.id; }

                if (row.MIMEtype === null || row.MIMEtype === "" || row.MIMEtype === "undefined")
                { MIMEtype = ""; }
                else
                { MIMEtype = row.MIMEtype; }
                if (row.contactname === null || row.contactname === "" || row.contactname === "undefined")
                { Contactname = ""; }
                else
                { Contactname = row.contactname; }
                if (row.company === null || row.company === "" || row.company === "undefined")
                { Company = ""; }
                else
                { Company = row.company; }
                if (row.website === null || row.website === "" || row.website === "undefined")
                { Website = ""; }
                else
                { Website = row.website; }
                if (row.catagory === null || row.catagory === "" || row.catagory === "undefined")
                { Category = ""; }
                else
                { Category = row.catagory; }
                if (row.biography === null || row.biography === "" || row.biography === "undefined")
                { biography = ""; }
                else
                { biography = row.biography; }
                if (row.position === null || row.position === "" || row.position === "undefined")
                { Position = ""; }
                else
                { Position = row.position; }
                if (row.flag === null || row.flag === "" || row.flag === "Undefined" || row.flag === "false")
                { Flag = ""; }
                else
                { Flag = row.flag; }

                if (row.address === null || row.address === "" || row.address === "Undefined" || row.address === "false")
                { Address = ""; }
                else
                { Address = row.address; }
                if (row.standno === null || row.standno === "" || row.standno === "Undefined" || row.standno === "false")
                { Standno = ""; }
                else
                { Standno = row.standno; }



                if (Flag === "") {





                    $('#exhibitorList').append(
                          '<li class="listex">' +
                                '<a href="#ExhibitorDetails"   onclick="getExhibitorClick(' + ID + ');"><img src="imagesExihibitor/' + ID + MIMEtype + '" class="ui-li-thumb" border="0" />' +
                                    '<h3 class="ui-li-heading">' + Company + '</h3>' +
                                    '<p class="ui-li-desc">Stand No:' + Standno + '</p>' +
                                    '<p class="ui-li-desc">Category/Industry: ' + Category + '</p>' +
                                '</a> ' +
                         '</li>'
                     );
                }
                else {

                    $('#exhibitorList').append(
                         '<li class="listex">' +
                             '<a href="#ExhibitorDetails"   onclick="getExhibitorClick(' + ID + ');"><img src="imagesExihibitor/' + ID + MIMEtype + '" class="ui-li-thumb"  border="0" />' +
                                    '<h3 class="ui-li-heading">' + Company + '</h3>' +
                                    '<p class="ui-li-desc">Stand No:' + Standno + '</p>' +
                                    '<p class="ui-li-desc">Category/Industry: ' + Category + '</p>' +
                                 '<span class="ui-li-count" style="border:0px; font-size:18px"><a href="#" style="padding:0px; margin:0px; border:0px; background:round" data-role="button" data-icon="star" data-iconpos="notext">star</a></span></span>' +
                             '</a> ' +
                      '</li>'
                    );
                }
                $('#exhibitorList').listview('refresh');
            }
            catch (e) {
            }

        }
        function getMoveToMap(ID)
        {
            db = openDatabase(shortName, version, displayName, maxSize);
            db.transaction(
                function (transaction) {
                    transaction.executeSql('select tbl_Exhibitor.id,tbl_Exhibitor.MAPMIMEType from tbl_Exhibitor where tbl_Exhibitor.id =  ?', [ID], function (transaction, results) {
                        if (results.rows.length != 0) {

                            document.getElementById('exihimapimg').src = "exhiMap/" + results.rows.item(0).id + results.rows.item(0).MAPMIMEType;
                            $.mobile.changePage("#ExhiMap");
                        }
                    });
                });
        }
        function getExhibitorClick(ID) {
            db = openDatabase(shortName, version, displayName, maxSize);
            db.transaction(

                function (transaction) {
                    transaction.executeSql('select tbl_Exhibitor.id,tbl_Exhibitor.facebook,tbl_Exhibitor.twitter,tbl_Exhibitor.linkedin,tbl_Exhibitor.event_code,tbl_Exhibitor.company,tbl_Exhibitor.standno,tbl_Exhibitor.catagory,tbl_Exhibitor.address,tbl_Exhibitor.phoneno,tbl_Exhibitor.email,tbl_Exhibitor.biography,tbl_Exhibitor.contactname,tbl_Exhibitor.website,tbl_Exhibitor.position, tbl_Exhibitor.sponsorshiplevel, tbl_Exhibitor.MIMEtype,tbl_Exhibitor.MAPMIMEType from tbl_Exhibitor where tbl_Exhibitor.id =  ?', [ID], function (transaction, results) {

                        if (results.rows.length != 0) {

                            $('#exhibitorList').empty();
                            for (i = 0; i < results.rows.length; i++) {
                                renderTodo(results.rows.item(0));

                                document.getElementById('ExhibitorImage').src = 'imagesExihibitor/' + results.rows.item(0).id + results.rows.item(0).MAPMIMEType;
                                var name = results.rows.item(0).contactname;

                                localStorage.setItem("ExhibitorDetailsID", ID);


                                document.getElementById('exihimapimg').src = "exhiMap/" + results.rows.item(0).id + results.rows.item(0).MIMEtype;

                                $('#exhibitorhiddenid').val(ID);
                                $('#toExhibitorId').val(ID);
                                $('#senderType2').val(2);
                                $('#txtExhiName').val(name);
                                localStorage.setItem("ReceiverName", name);
                                $('#txtExhiCompName').val(results.rows.item(0).company);
                                $('#txtExhiCatName').val(results.rows.item(0).catagory);
                                $('#txtExhiStandNo').val(results.rows.item(0).standno);
                                //$('#txtExhiWeb').val(results.rows.item(0).website);
                                $('#txtExhiEmail').val(results.rows.item(0).email);
                                $('#txtExhiPhone').val(results.rows.item(0).phoneno);
                                $('#txtExhiAddress').val(results.rows.item(0).address);
                                $('#txtExhiPosition').val(results.rows.item(0).position);
                                $('#txtExhiBio').val(results.rows.item(0).biography);


                                $('#messageToExhibitorHead').html('Message to <br />' + name);

                                var aTag = document.getElementById('exhibitorfacebooklink');
                                aTag.setAttribute('href', "http://" + results.rows.item(0).facebook.toString());

                                var aTag1 = document.getElementById('exhibitortwitterlink');
                                aTag1.setAttribute('href', "http://" + results.rows.item(0).twitter.toString());

                                var aTag2 = document.getElementById('exhibitorlinkedinlink');
                                aTag2.setAttribute('href', "http://" + results.rows.item(0).linkedin.toString());

                                //var aTag2 = document.getElementById('ExhiMap');
                                // aTag2.setAttribute('href', 'exhiMap/' + results.rows.item(0).id +results.rows.item(0).MAPMIMEType.toString());


                               // var node = document.getElementById("exhiMapLink");
                                //node.innerHTML = "<div Class='rounded-corners'> <a href='#ExhiMap'> Show On Map</a> </div></br>";

                                var aTag = document.getElementById('exhiMapLink');
                                aTag.setAttribute('href', "#ExhiMap");




                                var node = document.getElementById("exhiWebLink2");
                                node.innerHTML = "<div Class='rounded-corners'> <a href='http://" + results.rows.item(0).website + "' target='_blank' >" + results.rows.item(0).website + "</a> </div></br>";


                            }
                        }
                    });
                }

             );
        }
        function removeCredentials() {

            localStorage.setItem("EventCode", "");
            localStorage.setItem("UserCode", "");
            localStorage.setItem("AttendeeId", "");
            $.mobile.changePage("#home");
        }

        function getBackGroundRefresh() {

            if (navigator.onLine) {

                setTimeout(function () {
                    sendExhibitorFavToServer();
                    sendSpeakerFavToServer();
                    sendSessionFavToServer();
                    sendAttendeeFavToServer();
                    sendExhibitorFavToServer();
                    sendEventEvaluation();
                    getChoiceEventLoaded();
                    MessageToServer();
                    getSpeakerLoaded();//done
                    getSpeakerTosessionLoaded();//d
                    getSponsorLoaded();//d
                    getTwitterLinkLoaded();//d                     
                    getNewsLoaded();//d
                    getEventLoaded();//d
                    getSessionLoaded();//d
                    getEventQuestionsLoaded();//d
                    getAttendeeLoaded();//d
                    getNotificationsLoaded();     //d                 
                    getExibitorLoaded(); //d
                    getEventQuestionsOptionsLoaded();//d
                    getFavoriteAttendeeFromServer();//d
                    getFavoriteExhibitorFromServer();
                    getFavoriteSpeakerFromServer();
                    MessageFromServer();
                    getTwitterLinkUrl();
                }, 3600);

            }
            else {
                $().toastmessage('showToast', {
                    text: 'You are offline right now...',
                    sticky: false,
                    position: 'top-right',
                    type: 'error',
                    closeText: '',
                    close: function () {
                    }
                });
            }

        }

        function getRefresh() {
            if (navigator.onLine) {
                callRollinscreen();
                setTimeout(function () {

                    sendExhibitorFavToServer();
                    sendSpeakerFavToServer();
                    sendSessionFavToServer();
                    sendAttendeeFavToServer();
                    sendExhibitorFavToServer();
                    sendEventEvaluation();
                    getChoiceEventLoaded();
                    MessageToServer();
                    getSpeakerLoaded();//done
                    getSpeakerTosessionLoaded();//d
                    getSponsorLoaded();//d
                    getTwitterLinkLoaded();//d                   
                    getNewsLoaded();//d
                    getSessionLoaded();//d
                    getEventLoaded();//d
                    getEventQuestionsLoaded();//d
                    getAttendeeLoaded();//d
                    getNotificationsLoaded();     //d                 
                    getExibitorLoaded(); //d
                    getEventQuestionsOptionsLoaded();//d
                    getFavoriteAttendeeFromServer();//d
                    getFavoriteExhibitorFromServer();
                    getFavoriteSpeakerFromServer();
                    MessageFromServer();
                    getTwitterLinkUrl();

                }, 3600);
                hideRollingScreen();
            }
            else {
                $().toastmessage('showToast', {
                    text: 'You are offline right now...',
                    sticky: false,
                    position: 'top-right',
                    type: 'error',
                    closeText: '',
                    close: function () {
                    }
                });
            }
        }

        function getEventLoaded() {

            if (navigator.onLine) {
                PageMethods.GetEventData(onSucess, onError);
                function onSucess(result) {
                    var tempdb = db;
                    tempdb.transaction(
                        function (transaction) {
                            transaction.executeSql('Delete from tbl_Event');
                            ProcessEvent(result);
                        }
                     );

                }
                function onError(result) {
                }
            }
        }
        function ProcessEvent(result) {

            try {

                for (var i = 0 ; i < result.length; i++) {
                    var _eventcode = result[i]["EventCode"].toString();
                    var _userreqid = result[i]["UserRequestId"].toString();
                    var _eveusercontact = result[i]["UserContactNo"].toString();
                    var _eveuseremail = result[i]["UserEmail"].toString();
                    var _eventreqDate = result[i]["RequestDate"].toString();
                    var _evename = result[i]["EventName"].toString();
                    var _event_type = result[i]["EventType"].toString();
                    var _event_level = result[i]["EventLevel"].toString();
                    var _evestartdate = result[i]["EventStartDate"].toString();
                    var _eveenddate = result[i]["EventEndDate"].toString();
                    var _evestarttime = result[i]["EventStartTime"].toString();
                    var _evefinishtime = result[i]["EventEndTime"].toString();
                    var _MIMEtype = result[i]["MIMEType"].toString();
                    var _MIMEtype1 = result[i]["MIMEType1"].toString();
                    var _MIMEtype2 = result[i]["MIMEType2"].toString();
                    var _MIMEtype3 = result[i]["MIMEType3"].toString();
                    var _MIMEtype4 = result[i]["MIMEType4"].toString();
                    var _mapkey = result[i]["MapKey"].toString();
                    var _latitude = result[i]["Latitude"].toString();
                    var _longitude = result[i]["Longitude"].toString();
                    var _timeZone = result[i]["TimeZone"].toString();
                    var _company = result[i]["Company"].toString();
                    InsertEventToWebSql(_eventcode, _company, _userreqid, _eveusercontact, _eveuseremail, _eventreqDate, _evename, _event_type, _event_level, _evestartdate, _eveenddate, _evestarttime, _evefinishtime, _MIMEtype, _timeZone, _MIMEtype1, _MIMEtype2, _MIMEtype3, _MIMEtype4, _mapkey, _latitude, _longitude);
                }
            }
            catch (e) {
            }
        }

        function InsertEventToWebSql(_eventcode, _company, _userreqid, _eveusercontact, _eveuseremail, _eventreqDate, _evename, event_type, event_level, _evestartdate, _eveenddate, _evestarttime, _evefinishtime, _MIMEtype, _timeZone, _MIMEtype1, _MIMEtype2, _MIMEtype3, _MIMEtype4, _mapkey, _latitude, _longitude) {
            var tempdb = db;
            db.transaction(
              function (transaction) {
                  try {
                      transaction.executeSql('INSERT INTO tbl_Event(event_code,company_name, user_req_id,usercontact,useremail,eventreqDate,eventname,eventtype,eventlevel,evestartdate,eveenddate,evestarttime,evefinishtime,MIMEtype,timeZone,MIMEtype1,MIMEtype2,MIMEtype3,MIMEtype4,mapkey,latitude,longitude) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)',
                             [_eventcode.toString(), _company.toString(), _userreqid.toString(), _eveusercontact.toString(), _eveuseremail.toString(), _eventreqDate.toString(), _evename.toString(), event_type.toString(), event_level.toString(), _evestartdate.toString(), _eveenddate, _evestarttime, _evefinishtime, _MIMEtype, _timeZone, _MIMEtype1, _MIMEtype2, _MIMEtype3, _MIMEtype4, _mapkey, _latitude, _longitude]);
                  }
                  catch (e) {
                  }
              }
           );
        }


        function MessageFromServer() {
            if (navigator.onLine) {
                AttendeeId = localStorage.getItem("AttendeeId");
                PageMethods.GetAttaindeeMessages(AttendeeId, onSucess, onError);
                function onSucess(result) {
                    var tempdb = db;
                    tempdb.transaction(
                        function (transaction) {
                            transaction.executeSql('Delete from tbl_Message'); // attendee messages
                            ProcessAttaindeeMessagesFromServer(result);
                        }
                     );
                }
                function onError(result) {
                }
            }
            else {

            }
        }

        function ProcessAttaindeeMessagesFromServer(result) {
            try {
                for (var i = 0 ; i < result.length; i++) {
                    var _id = result[i]["ID"].toString();
                    var _fromid = result[i]["FromId"].toString();
                    var _toid = result[i]["ToId"].toString();
                    var _messageText = result[i]["MessageText"].toString();
                    var _messagedate = result[i]["MessageDate"].toString();
                    var _flag = result[i]["Flag"].toString();
                    var _FromName = result[i]["FromName"].toString();
                    var _ToName = result[i]["ToName"].toString();
                    var _SenderType = result[i]["SenderType"].toString();

                    InsertAttainDeeMessagesToWebSql(_id, _fromid, _toid, _messageText, _messagedate, _flag, _FromName, _ToName, _SenderType);

                }


            } catch (e) {

            }
        }

        function InsertAttainDeeMessagesToWebSql(_id, _fromid, _toid, _messageText, _messagedate, _flag, _FromName, _ToName, _SenderType) {

            try {
                var tempdb = openDatabase(shortName, version, displayName, maxSize);
                tempdb.transaction(
                  function (transaction) {
                      transaction.executeSql('INSERT INTO tbl_Message(id,fromid,toid,messsagetext,messagedate,flag,fromname,toname,sendertype) values(?,?,?,?,?,?,?,?,?)',
                             [parseInt(_id), parseInt(_fromid), parseInt(_toid), _messageText, _messagedate, _flag, _FromName, _ToName, _SenderType]);

                  });
            } catch (e) {
                //alert(e.messsage);
            }

        }

        function getSpeakerMessageFromServer() {
            if (navigator.onLine) {
                AttendeeId = localStorage.getItem("AttendeeId");
                PageMethods.GetSpeakerMessages(AttendeeId, onSucess, onError);
                function onSucess(result) {
                    var tempdb = db;
                    tempdb.transaction(
                        function (transaction) {
                            transaction.executeSql('Delete from tbl_Message '); // attendee messages
                            ProcessSpeakerMessages(result);
                        }
                     );

                }
                function onError(result) {
                }
            }
            else {
            }
        }

        function ProcessSpeakerMessages(result) {
            try {
                for (var i = 0 ; i < result.length; i++) {
                    var _id = result[i]["ID"].toString();
                    var _fromid = result[i]["FromId"].toString();
                    var _toid = result[i]["ToId"].toString();
                    var _messageText = result[i]["MessageText"].toString();
                    var _messagedate = result[i]["MessageDate"].toString();
                    var _flag = result[i]["Flag"].toString();
                    InsertSpeakerMessagesToWebSql(_id, _fromid, _toid, _messageText, _messagedate, _flag);
                }
            } catch (e) {
            }
        }
        function InsertSpeakerMessagesToWebSql(_id, _fromid, _toid, _messageText, _messagedate, _flag) {
            try {
                var tempdb = openDatabase(shortName, version, displayName, maxSize);
                tempdb.transaction(
                  function (transaction) {
                      transaction.executeSql('INSERT INTO tbl_Message (id,fromid,toid,messsagetext,messagedate,flag) values(?,?,?,?,?,?)',
                             [parseInt(_id), parseInt(_fromid), parseInt(_toid), _messageText, _messagedate, _flag]);

                  });
            } catch (e) {
                //alert(e.messsage);
            }
        }

        function getExhibitorMessageFromServer() {
            if (navigator.onLine) {
                AttendeeId = localStorage.getItem("AttendeeId");
                PageMethods.GetExhibitorMessages(AttendeeId, onSucess, onError);
                function onSucess(result) {
                    var tempdb = db;
                    tempdb.transaction(
                        function (transaction) {
                            transaction.executeSql('Delete from tbl_Message '); // attendee messages
                            ProcessExhibitorMessages(result);
                        }
                     );
                }
                function onError(result) {
                }
            }
        }

        function ProcessExhibitorMessages(result) {
            try {
                for (var i = 0 ; i < result.length; i++) {
                    var _id = result[i]["ID"].toString();
                    var _fromid = result[i]["FromId"].toString();
                    var _toid = result[i]["ToId"].toString();
                    var _messageText = result[i]["MessageText"].toString();
                    var _messagedate = result[i]["MessageDate"].toString();
                    var _flag = result[i]["Flag"].toString();
                    InsertExhibitorMessagesToWebSql(_id, _fromid, _toid, _messageText, _messagedate, _flag);

                }


            } catch (e) {

            }
        }
        function InsertExhibitorMessagesToWebSql(_id, _fromid, _toid, _messageText, _messagedate, _flag) {
            try {
                var tempdb = openDatabase(shortName, version, displayName, maxSize);
                tempdb.transaction(
                  function (transaction) {
                      transaction.executeSql('INSERT INTO tbl_Message  (id,fromid,toid,messsagetext,messagedate,flag) values(?,?,?,?,?,?)',
                             [parseInt(_id), parseInt(_fromid), parseInt(_toid), _messageText, _messagedate, _flag]);

                  });
            } catch (e) {
                // alert(e.messsage);
            }
        }
        function callRollinscreen() {
            setTimeout(function () {
                $.mobile.changePage("#AppUpdateScreen", { transition: 'slide' });
                $.mobile.showPageLoadingMsg();

            }, 0);
        }

        function hideRollingScreen() {
            setTimeout(function () {
                $.mobile.hidePageLoadingMsg();
                $.mobile.changePage("#cpanel", { transition: 'slide' });
            }, 3600);
        }

        function MessageToServer() {
            messageAttendeeArr = new Array();
            db = openDatabase(shortName, version, displayName, maxSize);
            db.transaction(
              function (transaction) {
                  transaction.executeSql('SELECT * from tbl_Message', [], function (transaction, results) {

                      for (i = 0; i < results.rows.length; i++) {
                          var AttendeeMessage =
                              {

                                  ID: results.rows.item(i).id,
                                  FromId: results.rows.item(i).fromid,
                                  ToId: results.rows.item(i).toid,
                                  MessageText: results.rows.item(i).messsagetext,
                                  FromName: results.rows.item(i).fromname,
                                  ToName: results.rows.item(i).toname,
                                  MessageDate: results.rows.item(i).messagedate,
                                  Flag: results.rows.item(i).flag,
                                  SenderType: results.rows.item(i).sendertype

                              }
                          messageAttendeeArr.push(AttendeeMessage);
                      }
                      sendAttendeeMessageToServer(messageAttendeeArr);
                  });
              }
           );
        }
        function sendAttendeeMessageToServer(messageAttendeeArr) {
            if (navigator.onLine) {
                var serializedEmployee = Sys.Serialization.JavaScriptSerializer.serialize(messageAttendeeArr);
                PageMethods.saveAttendeeMessage(serializedEmployee, callBackUpdateCustomer);
            }
        }
        function ExhibitorMessageToServer() {
            messageExhibitorArr = new Array();
            db = openDatabase(shortName, version, displayName, maxSize);
            db.transaction(
              function (transaction) {
                  transaction.executeSql('SELECT * from tbl_Message', [], function (transaction, results) {
                      for (i = 0; i < results.rows.length; i++) {
                          var ExhiMessage =
                              {
                                  ID: results.rows.item(i).id,
                                  FromId: results.rows.item(i).fromid,
                                  ToId: results.rows.item(i).toid,
                                  MessageText: results.rows.item(i).messsagetext,
                                  MessageDate: results.rows.item(i).messagedate,
                                  Flag: results.rows.item(i).flag
                              }
                          messageExhibitorArr.push(ExhiMessage);
                      }
                      sendexhiMessageToServer(messageExhibitorArr);
                  });
              }
           );
        }

        function sendexhiMessageToServer(messageExhibitorArr) {
            if (navigator.onLine) {
                var serializedEmployee = Sys.Serialization.JavaScriptSerializer.serialize(messageExhibitorArr);
                PageMethods.saveExhibitorMessage(serializedEmployee, callBackUpdateCustomer);
            }
        }
        function SpeakerMessageToServer() {
            messageSpeakerArr = new Array();
            db = openDatabase(shortName, version, displayName, maxSize);
            db.transaction(
              function (transaction) {
                  transaction.executeSql('SELECT * from tbl_Message', [], function (transaction, results) {
                      for (i = 0; i < results.rows.length; i++) {
                          var SpeakerMessage =
                              {

                                  ID: results.rows.item(i).id,
                                  FromId: results.rows.item(i).fromid,
                                  ToId: results.rows.item(i).toid,
                                  MessageText: results.rows.item(i).messsagetext,
                                  MessageDate: results.rows.item(i).messagedate,
                                  Flag: results.rows.item(i).flag
                              }
                          messageSpeakerArr.push(SpeakerMessage);
                      }
                      sendspeakerMessageToServer(messageSpeakerArr);
                  });
              }
           );
        }

        function sendspeakerMessageToServer(messageSpeakerArr) {
            if (navigator.onLine) {
                var serializedEmployee = Sys.Serialization.JavaScriptSerializer.serialize(messageSpeakerArr);
                PageMethods.saveSpeakerMessage(serializedEmployee, callBackUpdateCustomer);
            }
        }
        function getSpeakerTosessionLoaded() {
            if (navigator.onLine) {
                PageMethods.GetSpeakerToSession(onSucess, onError);
                function onSucess(result) {
                    var tempdb = db;
                    tempdb.transaction(
                        function (transaction) {
                            transaction.executeSql('Delete from tbl_SpeakerToSession');
                            ProcessSpeakerToSession(result);
                        }
                     );

                }
                function onError(result) {
                }
            }
        }
        function ProcessSpeakerToSession(result) {

            try {
                for (var i = 0 ; i < result.length; i++) {
                    var _id = result[i]["ID"].toString();
                    var _speakerid = result[i]["SpeakerId"].toString();
                    var _sessionid = result[i]["SessionId"].toString();
                    InsertSpeakerToSessionToWebSql(_id, _speakerid, _sessionid);
                }
            }
            catch (e) {
            }
        }
        function InsertSpeakerToSessionToWebSql(_id, _speakerid, _sessionid) {
            try {
                db = openDatabase(shortName, version, displayName, maxSize);
                db.transaction(

                    function (transaction) {

                        transaction.executeSql('insert into tbl_SpeakerToSession(id,speakerid,sessionid ) values(?,?,?)', [_id, _speakerid, _sessionid], function (transaction, results) { });
                    }
                 );
            } catch (e) {
            }
        }

        // get notification loaded 

        function getNotificationsLoaded() {
            if (navigator.onLine) {
                ecode = localStorage.getItem("EventCode");
                PageMethods.GetNotificationMessages(ecode, onSucess, onError);
                function onSucess(result) {
                    var tempdb = db;
                    tempdb.transaction(
                        function (transaction) {
                            transaction.executeSql('Delete from tbl_Notification');
                            ProcessNotification(result);
                        }
                     );

                }
                function onError(result) {
                }
            }
            else {
            }
        }

        function ProcessNotification(result) {
            try {
                for (var i = 0 ; i < result.length; i++) {
                    var _id = result[i]["ID"].toString();
                    var _message = result[i]["Message"].toString();
                    var _time = result[i]["Time"].toString();

                    InsertNotificationToWebSql(_id, _message, _time);
                }
            }
            catch (e) {
            }
        }
        function getFavoriteAttendeeFromServer() {

            if (navigator.onLine) {
                ucode = localStorage.getItem("AttendeeId");
                PageMethods.GetFavAttendee(ucode, onSucess, onError);
                function onSucess(result) {
                    var tempdb = db;
                    tempdb.transaction(
                        function (transaction) {
                            transaction.executeSql('Delete from tbl_FavoriteAttendee');
                            ProcessFavAttendee(result);
                        }
                     );

                }
                function onError(result) {
                }
            }
            else {
            }

        }

        function ProcessFavAttendee(result) {

            try {
                for (var i = 0 ; i < result.length; i++) {
                    var _id = result[i]["ID"].toString();
                    var _ucode = result[i]["Ucode"].toString();
                    var _attendeeid = result[i]["AttendeeId"].toString();
                    var _flag = result[i]["Flag"].toString();

                    InsertAttendeeFavoriteToWebSql(_id, _ucode, _attendeeid, _flag);
                }
            }
            catch (e) {
            }
        }

        function InsertAttendeeFavoriteToWebSql(_id, _ucode, _attendeeid, _flag) {

            try {
                db = openDatabase(shortName, version, displayName, maxSize);
                db.transaction(

                    function (transaction) {

                        transaction.executeSql('insert into tbl_FavoriteAttendee(ucode,attendeeid,flag) values(?,?,?)', [_ucode, _attendeeid, _flag], function (transaction, results) { });
                    }
                 );
            } catch (e) {
            }


        }


        function InsertNotificationToWebSql(_id, _message, _time) {
            try {
                db = openDatabase(shortName, version, displayName, maxSize);
                db.transaction(

                    function (transaction) {

                        transaction.executeSql('insert into tbl_Notification(id,message,notificationdate) values(?,?,?)', [_id, _message, _time], function (transaction, results) { });
                    }
                 );
            } catch (e) {
            }
        }
        function getFavoriteExhibitorFromServer() {
            if (navigator.onLine) {
                ucode = localStorage.getItem("AttendeeId");
                PageMethods.GetFavExhibitor(ucode, onSucess, onError);
                function onSucess(result) {
                    var tempdb = db;
                    tempdb.transaction(
                        function (transaction) {
                            transaction.executeSql('Delete from tbl_FavoriteExihibitor ');
                            ProcessFavExhibitor(result);
                        }
                     );

                }
                function onError(result) {
                }
            }
        }
        function ProcessFavExhibitor(result) {

            try {
                for (var i = 0 ; i < result.length; i++) {
                    var _id = result[i]["ID"].toString();
                    var _ucode = result[i]["Ucode"].toString();
                    var _exhiid = result[i]["ExhibitorId"].toString();
                    var _flag = result[i]["Flag"].toString();

                    InsertExhibitorFavoriteToWebSql(_id, _ucode, _exhiid, _flag);
                }
            }
            catch (e) {
            }
        }

        function InsertExhibitorFavoriteToWebSql(_id, _ucode, _exhiid, _flag) {

            try {
                db = openDatabase(shortName, version, displayName, maxSize);
                db.transaction(

                    function (transaction) {
                        transaction.executeSql('insert into tbl_FavoriteExihibitor (ucode,exhiid,flag) values(?,?,?)', [_ucode, _exhiid, _flag], function (transaction, results) { });
                    }
                 );
            } catch (e) {
            }
        }
        function getFavoriteSpeakerFromServer() {

            if (navigator.onLine) {
                ucode = localStorage.getItem("AttendeeId");
                PageMethods.GetFavSpeaker(ucode, onSucess, onError);
                function onSucess(result) {
                    var tempdb = db;
                    tempdb.transaction(
                        function (transaction) {
                            transaction.executeSql('Delete from tbl_FavoriteSpeaker ');
                        }
                     );
                    ProcessFavExhibitor(result);
                }
                function onError(result) {
                }
            }
        }

        function ProcessFavSpeaker(result) {

            try {
                for (var i = 0 ; i < result.length; i++) {
                    var _id = result[i]["ID"].toString();
                    var _ucode = result[i]["Ucode"].toString();
                    var _spakerid = result[i]["SpeakerId"].toString();
                    var _flag = result[i]["Flag"].toString();

                    InsertSpeakerFavoriteToWebSql(_id, _ucode, _exhiid, _flag);
                }
            }
            catch (e) {
            }
        }

        function InsertSpeakerFavoriteToWebSql(_id, _ucode, _spakerid, _flag) {

            try {
                db = openDatabase(shortName, version, displayName, maxSize);
                db.transaction(

                    function (transaction) {
                        transaction.executeSql('insert into tbl_FavoriteSpeaker(ucode,speakerid,flag) values(?,?,?)', [_ucode, _spakerid, _flag], function (transaction, results) { });
                    }
                 );
            } catch (e) {
            }
        }

        function sendAttendeeFavToServer() {
            FavAttendeeArr = new Array();
            db = openDatabase(shortName, version, displayName, maxSize);
            db.transaction(
              function (transaction) {
                  transaction.executeSql('SELECT * from tbl_FavoriteAttendee', [], function (transaction, results) {
                      for (i = 0; i < results.rows.length; i++) {
                          var FavAttendee =
                              {
                                  ID: results.rows.item(i).id,
                                  AttendeeId: results.rows.item(i).attendeeid,
                                  Ucode: results.rows.item(i).ucode,
                                  Flag: results.rows.item(i).flag,
                              }
                          FavAttendeeArr.push(FavAttendee);
                      }
                      sendAttendeeFavoriteToServer(FavAttendeeArr);
                  });
              }
           );
        }
        function sendAttendeeFavoriteToServer(FavAttendeeArr) {
            if (navigator.onLine) {
                var serializedEmployee = Sys.Serialization.JavaScriptSerializer.serialize(FavAttendeeArr);
                PageMethods.FavoriteAttendeeMethod(serializedEmployee, callBackUpdateCustomer);
            }
        }


        function sendExhibitorFavToServer() {
            FavExhiArr = new Array();
            db = openDatabase(shortName, version, displayName, maxSize);
            db.transaction(
              function (transaction) {
                  transaction.executeSql('SELECT * from tbl_FavoriteExihibitor', [], function (transaction, results) {
                      for (i = 0; i < results.rows.length; i++) {
                          var FavExhi =
                              {
                                  ID: results.rows.item(i).id,
                                  ExhibitorId: results.rows.item(i).exhiid,
                                  Ucode: results.rows.item(i).ucode,
                                  Flag: results.rows.item(i).flag,
                              }
                          FavExhiArr.push(FavExhi);
                      }
                      sendExhiFavoriteToServer(FavExhiArr);
                  });
              }
           );
        }

        function sendExhiFavoriteToServer(FavExhiArr) {
            if (navigator.onLine) {
                var serializedEmployee = Sys.Serialization.JavaScriptSerializer.serialize(FavExhiArr);
                PageMethods.FavoriteExhibitorMethod(serializedEmployee, callBackUpdateCustomer);
            }
        }

        function sendSpeakerFavToServer() {

            FavSpeakerArr = new Array();
            db = openDatabase(shortName, version, displayName, maxSize);
            db.transaction(
              function (transaction) {
                  transaction.executeSql('select * from tbl_FavoriteSpeaker', [], function (transaction, results) {
                      for (i = 0; i < results.rows.length; i++) {
                          var FavSpeaker =
                              {
                                  ID: results.rows.item(i).id,
                                  SpeakerId: results.rows.item(i).speakerid,
                                  Ucode: results.rows.item(i).ucode,
                                  Flag: results.rows.item(i).flag,

                              }
                          FavSpeakerArr.push(FavSpeaker);
                      }
                      sendspeakFavoriteToServer(FavSpeakerArr);
                  });
              }
           );
        }

        function sendspeakFavoriteToServer(FavSpeakerArr) {
            if (navigator.onLine) {
                var serializedEmployee = Sys.Serialization.JavaScriptSerializer.serialize(FavSpeakerArr);
                PageMethods.FavoriteSpeakerMethod(serializedEmployee, callBackUpdateCustomer);
            }
            else {
            }
        }
        function sendUpdatedAttendee() {
            attendeeArr = new Array();
            db = openDatabase(shortName, version, displayName, maxSize);
            db.transaction(
              function (transaction) {
                  transaction.executeSql('SELECT * from tbl_Attendee where offlineUpdate="YES"', [], function (transaction, results) {

                      for (i = 0; i < results.rows.length; i++) {
                          var Attendee = {
                              ID: results.rows.item(i).id,
                              EventCode: results.rows.item(i).event_code,
                              AttendeeLevel: results.rows.item(i).Attendee_Level,
                              Title: results.rows.item(i).Title,
                              FirstName: results.rows.item(i).Firstname,
                              LastName: results.rows.item(i).Lastname,
                              Email: results.rows.item(i).Email,
                              Company: results.rows.item(i).company,
                              Position: results.rows.item(i).Position,
                              Category: results.rows.item(i).Category_Industry,
                              Address: results.rows.item(i).Address,
                              PhoneNo: results.rows.item(i).Phone_Number,
                              Biography: results.rows.item(i).Biography,
                              Website: results.rows.item(i).Website,
                              MIMEType: results.rows.item(i).MIMEtype,
                              Checkin: results.rows.item(i).checkin
                          }
                          attendeeArr.push(Attendee);
                      }
                      sendtoupdatedAttendeeToServer(attendeeArr);
                  });
              }
           );
        }
        function sendtoupdatedAttendeeToServer(attendeeArrTemp) {

            if (navigator.onLine) {
                var serializedEmployee = Sys.Serialization.JavaScriptSerializer.serialize(attendeeArr);
                PageMethods.Updateprofile(serializedEmployee, callBackUpdateCustomer);
            }
        }

        function callBackUpdateCustomer(result) {
        }
        function sendSessionFavToServer() {
            FavSessionrArr = new Array();
            db = openDatabase(shortName, version, displayName, maxSize);
            db.transaction(

              function (transaction) {


                  transaction.executeSql('select * from tbl_FavoriteSession', [], function (transaction, results) {

                      for (i = 0; i < results.rows.length; i++) {
                          var FavSession =
                              {
                                  ID: results.rows.item(i).id,
                                  SessionId: results.rows.item(i).sessionid,
                                  Ucode: results.rows.item(i).ucode,
                                  Flag: results.rows.item(i).flag,
                              }
                          FavSessionrArr.push(FavSession);
                      }
                      sendFavSessionToServer(FavSessionrArr);
                  });
              }
              );
        }

        function sendFavSessionToServer(FavSessionrArr) {
            if (navigator.onLine) {
                var serializedEmployee = Sys.Serialization.JavaScriptSerializer.serialize(FavSessionrArr);
                PageMethods.FavoriteSessionMethod(serializedEmployee, callBackUpdateCustomer);
            }
        }


        function sendEventEvaluation() {
            eventEvalArry = new Array();
            db = openDatabase(shortName, version, displayName, maxSize);
            db.transaction(
              function (transaction) {
                  transaction.executeSql('select * from tbl_QuestionAnswers', [], function (transaction, results) {
                      for (i = 0; i < results.rows.length; i++) {
                          var EventEvaluation =
                              {

                                  ID: results.rows.item(i).id,
                                  EventCode: results.rows.item(i).event_code,
                                  QuestionId: results.rows.item(i).questionId,
                                  AttendeeId: results.rows.item(i).attendeeid,
                                  OptionValue: results.rows.item(i).optionid,
                                  //OtherText: results.rows.item(i).otherText

                              }
                          eventEvalArry.push(EventEvaluation);
                      }
                      sendEventEvalutionToServer(eventEvalArry);
                  });
              }
           );
        }
        function sendEventEvalutionToServer(eventEvalArry) {

            if (navigator.onLine) {

                var serializedEmployee = Sys.Serialization.JavaScriptSerializer.serialize(eventEvalArry);
                PageMethods.EventEvaluationMethod(serializedEmployee, callBackUpdateCustomer);

            }
        }
        function getEventQuestionsLoaded() {

            if (navigator.onLine) {
                AttendeeId = localStorage.getItem("AttendeeId");
                PageMethods.GetEventQuestions(AttendeeId, onSucess, onError);
                function onSucess(result) {
                    var tempdb = db;
                    tempdb.transaction(
                        function (transaction) {
                            transaction.executeSql('Delete from tbl_QuestionsEvent');
                            ProcessEventQuestions(result);
                        }
                     );

                }
                function onError(result) {
                }
            }
            else {
            }

        }

        function ProcessEventQuestions(result) {

            try {
                for (var i = 0 ; i < result.length; i++) {
                    var _id = result[i]["Id"].toString();
                    var _questionText = result[i]["Question"].toString();
                    var _eventcode = result[i]["EventCode"].toString();
                    //var _sessionid = result[i]["SessionId"].toString();

                    InsertEventQuestionsToWebSql(_id, _questionText, _eventcode);//, _sessionid);
                }
            }
            catch (e) {
            }
        }

        function InsertEventQuestionsToWebSql(_id, _questionText, _eventcode)//, _sessionid)
        {
            var tempdb = db;
            db.transaction(
              function (transaction) {
                  try {
                      transaction.executeSql('INSERT INTO tbl_QuestionsEvent(id,event_code,questionText) values(?,?,?)',
                               [parseInt(_id), _eventcode, _questionText]);
                  }
                  catch (e) {
                  }
              }
           );
        }


        function getEventQuestionsOptionsLoaded() {
            if (navigator.onLine) {
                PageMethods.GetEventQuestionsOptions(onSucess, onError);
                function onSucess(result) {
                    var tempdb = db;
                    tempdb.transaction(
                        function (transaction) {
                            transaction.executeSql('Delete from tbl_QuestionsEventOption');
                            ProcessQuestionOptions(result);
                        }
                     );

                }
                function onError(result) {
                }
            }
            else {
            }
        }

        function ProcessQuestionOptions(result) {
            try {

                for (var i = 0 ; i < result.length; i++) {

                    var _id = result[i]["Id"].toString();
                    var _questionid = result[i]["Questionid"].toString();
                    var _option1 = result[i]["Option1"].toString();
                    var _option2 = result[i]["Option2"].toString();
                    var _option3 = result[i]["Option3"].toString();
                    var _option4 = result[i]["Option4"].toString();

                    InsertQuestionOptionsToWebSql(_id, _questionid, _option1, _option2, _option3, _option4);
                }
            }
            catch (e) {
            }
        }

        function InsertQuestionOptionsToWebSql(_id, _questionid, _option1, _option2, _option3, _option4) {
            var tempdb = db;
            db.transaction(
              function (transaction) {
                  try {
                      transaction.executeSql('INSERT INTO tbl_QuestionsEventOption(id,questionid,option1,option2,option3,option4) values(?,?,?,?,?,?)',
                               [parseInt(_id), _questionid, _option1, _option2, _option3, _option4]);
                  }
                  catch (e) {
                  }
              }
           );
        }


        function getSessionLoaded() {
            if (navigator.onLine) {
                AttendeeId = localStorage.getItem("AttendeeId");
                PageMethods.GetSessionData(AttendeeId, onSucess, onError);
                function onSucess(result) {
                    var tempdb = db;
                    tempdb.transaction(
                        function (transaction) {
                            transaction.executeSql('Delete from tbl_Session');
                            ProcessSession(result);
                        }
                     );

                }
                function onError(result) {
                }
            }

        }

        function ProcessSession(result) {

            try {

                for (var i = 0 ; i < result.length; i++) {

                    var _id = result[i]["ID"].toString();
                    var _eventcode = result[i]["EventCode"].toString();
                    var _SessiontTitle = result[i]["SessiontTitle"].toString();
                    var _SessionDate = result[i]["SessionDate"].toString();
                    var _SessionStartTime = result[i]["SessionStartTime"].toString();
                    var _SessionFinishTime = result[i]["SessionFinishTime"].toString();
                    var _SessionLocation = result[i]["SessionLocation"].toString();
                    var _Overview = result[i]["Overview"].toString();
                    var _SessionSpeakerFirstName = result[i]["SessionSpeakerFirstName"].toString();
                    //var _SessionSpeakerlastName = result[i]["SessionSpeakerlastName"].toString();
                    InsertSessionToWebSql(_id, _eventcode, _SessiontTitle, _SessionDate, _SessionStartTime, _SessionFinishTime, _SessionLocation, _Overview, _SessionSpeakerFirstName);
                }
            }
            catch (e) {
            }
        }

        function InsertSessionToWebSql(_id, _eventcode, _SessiontTitle, _SessionDate, _SessionStartTime, _SessionFinishTime, _SessionLocation, _Overview, _SessionSpeakerFirstName) {
            var tempdb = db;
            db.transaction(
              function (transaction) {
                  transaction.executeSql('INSERT INTO tbl_Session(id,event_code,sessionTitle, sessionDate, sessionStartTime,sessionFinishTime,sessionLocation,overview,sessionSpeakerFname) values(?,?,?,?,?,?,?,?,?)',
                         [parseInt(_id), _eventcode.toString(), _SessiontTitle.toString(), _SessionDate.toString(), _SessionStartTime.toString(), _SessionFinishTime.toString(), _SessionLocation.toString(), _Overview.toString(), _SessionSpeakerFirstName.toString()]);
              }
           );
        }



        function getNewsLoaded() {
            if (navigator.onLine) {
                AttendeeId = localStorage.getItem("AttendeeId");
                PageMethods.GetNewsData(AttendeeId, onSucess, onError);
                function onSucess(result) {
                    var tempdb = db;
                    tempdb.transaction(
                        function (transaction) {
                            transaction.executeSql('Delete from tbl_News');
                            ProcessNews(result);
                        }
                     );

                }
                function onError(result) {
                }
            }
        }

        function ProcessNews(result) {

            try {

                for (var i = 0 ; i < result.length; i++) {
                    var _id = result[i]["ID"].toString();
                    var _eventcode = result[i]["EventCode"].toString();
                    var _attaindeeLevel = result[i]["AttendeeLevel"].toString();
                    var _newsDate = result[i]["NewsDate"].toString();
                    var _authorName = result[i]["AuthorName"].toString();
                    var _short = result[i]["Short"].toString();
                    var _description = result[i]["Discription"].toString();
                    var _Newsid = result[i]["NewsID"].toString();
                    var _title = result[i]["Title"].toString();
                    var _newstime = result[i]["NewsTime"].toString();
                    var _MIMEtype = result[i]["MIMETYPE"].toString();

                    var _FileName = result[i]["FileName"].toString();
                    var _FileExtension = result[i]["FileExtension"].toString();
                    var _FileType = result[i]["FileType"].toString();


                    InsertNewsToWebSql(_id, _eventcode, _attaindeeLevel, _newsDate, _authorName, _short, _description, _Newsid, _title, _newstime, _MIMEtype, _FileName, _FileExtension, _FileType);
                }
            }
            catch (e) {
            }
        }

        function InsertNewsToWebSql(_id, _eventcode, _attaindeeLevel, _newsDate, _authorName, _short, _description, _Newsid, _title, _newstime, _MIMEtype, _FileName, _FileExtension, _FileType) {
            var tempdb = db;
            db.transaction(
              function (transaction) {
                  transaction.executeSql('INSERT INTO tbl_News(id,event_code,attaindeeLevel,authorName,newsdate,short,description,Newsid,title,newstime,MIMEtype,filename,fileextention,contenttype) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?)',
                         [parseInt(_id), _eventcode, _attaindeeLevel, _authorName, _newsDate, _short, _description, _Newsid, _title, _newstime, _MIMEtype, _FileName, _FileExtension, _FileType]);
              }
           );
        }



        function getNews() {
            try {
                db = openDatabase(shortName, version, displayName, maxSize);
                db.transaction(

                    function (transaction) {

                        transaction.executeSql('SELECT * FROM tbl_News where event_code=?', [ecode], function (transaction, results) {
                            $('#NewsList').empty();
                            for (i = 0; i < results.rows.length; i++) {
                                renderNewsList(results.rows.item(i));
                            }
                        });


                    }

                 );
            } catch (e) {
            }
        }

        function renderNewsList(row) {

            try {

                var ID, Title, MIMEtype, NewsDate, AuthorName, NewsTime;
                if (row.id === null || row.id === "")
                { ID = ""; }
                else
                { ID = row.id; }
                if (row.title === null || row.title === "")
                { Title = ""; }
                else
                { Title = row.title; }
                if (row.newsdate === null || row.newsdate === "")
                { NewsDate = ""; }
                else
                { NewsDate = row.newsdate; }

                if (row.MIMEtype === null || row.MIMEtype === "")
                { MIMEtype = ""; }
                else
                { MIMEtype = row.MIMEtype; }
                if (row.authorName === null || row.authorName === "")
                { AuthorName = ""; }
                else
                { AuthorName = row.authorName; }

                if (row.newstime === null || row.newstime === "") {
                    NewsTime = "";
                } else {
                    NewsTime = row.newstime;
                }

                NewsDate = NewsDate.substr(0, NewsDate.indexOf(' '));




                $('#NewsList').append(
                  '<li class="listex">' +
                    '<a href="#newsDetails"  onclick="onNewsClick(' + ID + ');"  border="0">' +
                         '<img alt="" id="pic" src="imagesNews/' + ID + MIMEtype + '" class="ui-li-thumb"/>' +
                         '<h3> ' + Title + '</h3>' +
                         '<p>' + NewsDate + ' ' + NewsTime + ' by ' + AuthorName + '</p>' +
                    '</a>' +
                  '</li>'
                 );

                $('#NewsList').listview('refresh');

            } catch (e) {
            }

        }

        function onNewsClick(ID) {
            db = openDatabase(shortName, version, displayName, maxSize);
            db.transaction(

                function (transaction) {
                    transaction.executeSql('SELECT * FROM tbl_News where tbl_News.id =  ?', [ID], function (transaction, results) {
                        if (results.rows.length === 0) {
                            $('#exhibitorList').empty();
                        }
                        else {
                            $('#exhibitorList').empty();
                            for (i = 0; i < results.rows.length; i++) {
                                renderTodo(results.rows.item(0));
                                localStorage.setItem("newsDetailsID", ID);
                                document.getElementById('newsImage').src = 'imagesNews/' + results.rows.item(0).id + results.rows.item(0).MIMEtype;
                                var name = results.rows.item(0).title;
                                $('#newshiddenid').val(ID);
                                $('#txtNewsTitle').val(name);
                                var NewsDate;
                                try {
                                    NewsDate = results.rows.item(0).newsdate;
                                    NewsDate = NewsDate.substr(0, NewsDate.indexOf(' '));
                                } catch (e) {

                                }

                                $('#txtNewsDate').val(NewsDate);
                                $('#txtNewstime').val(results.rows.item(0).newstime);
                                $('#txtAuthor').val(results.rows.item(0).authorName);
                                //$('#txtSdiscrip').val(results.rows.item(0).short);
                                $('#txtNewsdiscrip').val(results.rows.item(0).description);
                                //filename,fileextention,contenttype
                                var aTag = document.getElementById('newsimagelink');
                                aTag.setAttribute('href', 'otherfiles/' + results.rows.item(0).filename);


                            }
                        }
                    });
                }

             );

        }
        function getTwitterLinkLoaded() {
            if (navigator.onLine) {
                ecode = localStorage.getItem("EventCode");
                PageMethods.GetTwitterLinking(ecode, onSucess, onError);
                function onSucess(result) {
                    var tempdb = db;
                    tempdb.transaction(
                        function (transaction) {
                            transaction.executeSql('Delete from tbl_twitter');
                            ProcessTwitter(result);
                        }
                     );
                }
                function onError(result) {
                }
            }
            else {
            }
        }
        function ProcessTwitter(result) {
            try {

                for (var i = 0 ; i < result.length; i++) {
                    var _id = result[i]["ID"].toString();
                    var _eventcode = result[i]["EventCode"].toString();
                    var _twitterlink = result[i]["Twitterlink"].toString();
                    var _twitterid = result[i]["TwitterID"].toString();
                    InsertTwitterToWebSql(_id, _eventcode, _twitterlink, _twitterid);
                }
            }
            catch (e) {
            }

        }

        function InsertTwitterToWebSql(_id, _eventcode, _twitterlink, _twitterid) {

            db = openDatabase(shortName, version, displayName, maxSize);
            db.transaction(

                function (transaction) {
                    //tlink,twitterid
                    transaction.executeSql('insert into tbl_twitter(id,event_code,tlink,twitterid) values(?,?,?,?)', [parseInt(_id), _eventcode, _twitterlink, _twitterid], function (transaction, results) {

                    });

                }

             );
        }


        function getSponsorLoaded() {

            if (navigator.onLine) {
                // updating exhibitors...
                AttendeeId = localStorage.getItem("AttendeeId");
                PageMethods.GetSponsorData(AttendeeId, onSucess, onError);
                function onSucess(result) {
                    var tempdb = db;
                    tempdb.transaction(
                        function (transaction) {
                            transaction.executeSql('Delete from tbl_Sponsor');
                            ProcessSponsors(result);
                        }
                     );

                }
                function onError(result) {
                }
            }
            else {
            }


        }
        function ProcessSponsors(result) {
            try {


                for (var i = 0 ; i < result.length; i++) {
                    var _id = result[i]["ID"].toString();
                    var _eventcode = result[i]["EventCode"].toString();
                    var _sponsorname = result[i]["SponsorName"].toString();
                    var _discription = result[i]["Discription"].toString();
                    var _mime = result[i]["MIMEType"].toString();
                    var _product1 = result[i]["Product1"].toString();
                    var _product2 = result[i]["Product2"].toString();
                    var _product3 = result[i]["Product3"].toString();
                    var _product4 = result[i]["Product4"].toString();
                    var _product5 = result[i]["Product5"].toString();
                    var _facebook = result[i]["FacebookURL"].toString();
                    var _twitter = result[i]["TwitterURL"].toString();
                    var _youtube = result[i]["YouTubeURL"].toString();
                    var _contactname = result[i]["Contactname"].toString();
                    var _phone = result[i]["Phone"].toString();
                    var _email = result[i]["Email"].toString();
                    var _position = result[i]["Position"].toString();
                    var _Address = result[i]["Address"].toString();
                    var _Adminlink = result[i]["AdminLink"].toString();
                    var _website = result[i]["Website"].toString();
                    InsertSponsorToWebSql(_id, _eventcode, _sponsorname, _discription, _mime, _product1, _product2, _product3, _product4, _product5, _facebook, _youtube, _twitter, _contactname, _phone, _email, _position, _Address, _Adminlink, _website);
                }
            }
            catch (e) {
            }
        }

        function InsertSponsorToWebSql(_id, _eventcode, _sponsorname, _discription, _mime, _product1, _product2, _product3, _product4, _product5, _facebook, _youtube, _twitter, _contactname, _phone, _email, _position, _Address, _Adminlink, _website) {
            db = openDatabase(shortName, version, displayName, maxSize);
            db.transaction(
                function (transaction) {
                    transaction.executeSql('insert into tbl_Sponsor(id,event_code,sponsorname,discription,MIMEtype,product1,product2,product3,product4,product5,facebook,youtube,twitter,contactname, phone, email,position,address,adminlink,website) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)', [parseInt(_id), _eventcode, _sponsorname, _discription, _mime, _product1, _product2, _product3, _product4, _product5, _facebook, _youtube, _twitter, _contactname, _phone, _email, _position, _Address, _Adminlink, _website], function (transaction, results) {
                    });
                }
             );
        }

        function getSponsor() {
            try {
                db = openDatabase(shortName, version, displayName, maxSize);
                db.transaction(
                    function (transaction) {
                        ecode = localStorage.getItem("EventCode");
                        transaction.executeSql('select id,event_code,sponsorname,discription,MIMEtype,product1,product2,product3,product4,product5,facebook,youtube,twitter,contactname,phone,email,position from tbl_Sponsor where tbl_Sponsor.event_code=?', [ecode], function (transaction, results) {
                            $('#sponsorList').empty();
                            if (results.rows.length != 0) {
                                for (i = 0; i < results.rows.length; i++) {
                                    renderSponsorTodo(results.rows.item(i));
                                }
                            }
                        });
                    }
                 );
            } catch (e) {
            }
        }

        function renderSponsorTodo(row) {
            try {

                var ID, Sponsorname, Discription, MIMEtype, Flag, Contactname;
                ID = row.id;
                MIMEtype = row.MIMEtype;
                Sponsorname = row.sponsorname;
                Discription = row.discription;
                Contactname = row.contactname;
                if (row.sponsorname === null || row.sponsorname === "")
                { Sponsorname = ""; }
                else
                { Sponsorname = row.sponsorname; }
                if (row.discription === null || row.discription === "")
                { Discription = ""; }
                else
                { Discription = row.discription; }
                if (row.contactname === null || row.contactname === "")
                { Contactname = ""; }
                else
                { Contactname = row.contactname; }
                $('#sponsorList').append(
                  '<li class="listex">' +
                    '<a href="#sponsorDetails"   onclick="onSponsorClick(' + ID + ');">' +
                         '<img alt="" id="pic" src="imagesSponsor/' + ID + MIMEtype + '" class="ui-li-thumb" />' +
                         '<h3 class="ui-li-heading">' + Sponsorname + '</h3>' +
                    '</a>' +
                  '</li>'
                 );
                $('#sponsorList').listview('refresh');
            }
            catch (e) {
            }
        }

        function onSponsorClick(ID) {
            db = openDatabase(shortName, version, displayName, maxSize);
            db.transaction(
                function (transaction) {
                    transaction.executeSql('select id,event_code,sponsorname,discription,MIMEtype,product1,product2,product3,product4,product5,facebook,youtube,twitter,contactname,phone,email,position  from tbl_Sponsor where tbl_Sponsor.id =  ?', [ID], function (transaction, results) {
                        if (results.rows.length === 0) {
                            $('#sponsorList').empty();
                        }
                        else {
                            $('#sponsorList').empty();
                            for (i = 0; i < results.rows.length; i++) {
                                renderTodo(results.rows.item(0));
                                localStorage.setItem("SponsorDetailsID", ID);
                                $('#toSponsorId').val(ID);
                                $('#senderType4').val(4);
                                document.getElementById('sponsorImage').src = 'imagesSponsor/' + results.rows.item(0).id + results.rows.item(0).MIMEtype;
                                var name = results.rows.item(0).sponsorname;
                                $('#txtSponName').val(name);
                                $('#messagetoSponsorHead').html('Message to <br />' + name);
                                localStorage.setItem("ReceiverName", name);
                                $('#txtSponBio').val(results.rows.item(0).discription);
                                $('#txtsponsorconatctname').val(results.rows.item(0).contactname);
                                $('#txtsponsorphone').val(results.rows.item(0).phone);
                                $('#txtsponsoremail').val(results.rows.item(0).email);
                                $('#txtsponsorconatctname').val(results.rows.item(0).contactname);
                                $('#txtsponposi').val(results.rows.item(0).position);
                                $('#txtsponAddress').val(results.rows.item(0).address);
                                var node = document.getElementById("sponsorwebLinks");
                                node.innerHTML = "<div Class='rounded-corners'> <a href='http://" + results.rows.item(0).product1 + "' target='_blank'>" + results.rows.item(0).product1 + "</a>  </div></br>";
                                var node1 = document.getElementById("sponsorwebLinks1");
                                node1.innerHTML = " <div Class='rounded-corners'> <a href='http://" + results.rows.item(0).product2 + "' target='_blank'>" + results.rows.item(0).product2 + "</a> </div> </br>";
                                var node2 = document.getElementById("sponsorwebLinks2");
                                node2.innerHTML = " <div Class='rounded-corners'> <a href='http://" + results.rows.item(0).product3 + "' target='_blank'>" + results.rows.item(0).product3 + "</a> </div> </br>";
                                var node3 = document.getElementById("sponsorwebLinks3");
                                node3.innerHTML = " <div Class='rounded-corners'> <a href='http://" + results.rows.item(0).product4 + "' target='_blank'>" + results.rows.item(0).product4 + "</a> </div> </br>";
                                var node4 = document.getElementById("sponsorwebLinks4");
                                node4.innerHTML = " <div Class='rounded-corners'> <a href='http://" + results.rows.item(0).product5 + "' target='_blank'>" + results.rows.item(0).product5 + "</a> </div> </br>";
                                var aTag = document.getElementById('sponsorfacebooklink');
                                aTag.setAttribute('href', "http://" + results.rows.item(0).facebook.toString());
                                var aTag1 = document.getElementById('sponsortwitterlink');
                                aTag1.setAttribute('href', "http://" + results.rows.item(0).twitter.toString());
                                var aTag2 = document.getElementById('sponsoryoutubelink');
                                aTag2.setAttribute('href', "http://" + results.rows.item(0).youtube.toString());
                            }
                        }
                    });
                }
             );
        }
        function getSpeakerLoaded() {
            if (navigator.onLine) {
                AttendeeId = localStorage.getItem("AttendeeId");
                PageMethods.GetSpeakerData(AttendeeId, onSucess, onError);
                function onSucess(result) {
                    var tempdb = db;
                    tempdb.transaction(
                        function (transaction) {
                            transaction.executeSql('Delete from tbl_Speaker');
                            ProcessSpeaker(result);
                        }
                     );

                }
                function onError(result) {
                }
            }
        }
        function ProcessSpeaker(result) {
            try {
                for (var i = 0 ; i < result.length; i++) {
                    var _id = result[i]["ID"].toString();
                    var _eventcode = result[i]["EventCode"].toString();
                    var _title = result[i]["Title"].toString();
                    var _Firstname = result[i]["FirstName"].toString();
                    var _lastname = result[i]["LastName"].toString();
                    var _company = result[i]["Company"].toString();
                    var _position = result[i]["Position"].toString();
                    var _category = result[i]["Category"].toString();
                    var _address = result[i]["Address"].toString();
                    var _phoneno = result[i]["PhoneNo"].toString();
                    var _email = result[i]["Email"].toString();
                    var _biography = result[i]["Biography"].toString();
                    var _website = result[i]["Website"].toString();
                    var _MIMEtype = result[i]["MimeType"].toString();
                    var _facebook = result[i]["Facebook"].toString();
                    var _twitter = result[i]["Twitter"].toString();
                    var _linkedin = result[i]["LinkedIn"].toString();
                    var _adminlink = result[i]["AdminLink"].toString();
                    InsertSpeakersToWebSql(_id, _eventcode, _title, _Firstname, _lastname, _company, _position, _category, _phoneno, _email, _biography, _website, _MIMEtype, _address, _facebook, _twitter, _linkedin, _adminlink);
                }
            }
            catch (e) {
            }
        }
        function InsertSpeakersToWebSql(_id, _eventcode, _title, _Firstname, _lastname, _company, _position, _category, _phoneno, _email, _biography, _website, _MIMEtype, _address, _facebook, _twitter, _linkedin, _adminlink) {
            var tempdb = db;
            db.transaction(
              function (transaction) {
                  transaction.executeSql('INSERT INTO tbl_speaker(id,event_code ,title , firstname , lastname,position,categoryIndustry,company,address,phoneno,email,website,biography,MIMEtype,facebook, twitter, linkedin,adminlink) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)',
                         [parseInt(_id), _eventcode.toString(), _title.toString(), _Firstname.toString(), _lastname.toString(), _position.toString(), _category.toString(), _company.toString(), _address.toString(), _phoneno.toString(), _email.toString(), _website.toString(), _biography.toString(), _MIMEtype.toString(), _facebook.toString(), _twitter.toString(), _linkedin.toString(), _adminlink.toString()]);
              }
           );
        }

        function runScript(e) {
            if (e.keyCode == 13) {
                getLogin();
                return true;
            }
        }
        function submitNote(_sessionID) {
            var _sessionnote = $("#txtSessionNote").val();
            db = openDatabase(shortName, version, displayName, maxSize);
            db.transaction(
                function (transaction) {
                    transaction.executeSql('insert into tbl_SessionNote(ucode,sessionid,note) values(?,?,?)', [ucode, _sessionID, _sessionnote], function (transaction, results) {
                    });
                }
             );
            $("#txtSessionNote").val("");
        }
        function GetReceivedMessages() {
            try {
                window.setTimeout(function () {
                    MessageToServer();
                    MessageFromServer();
                }, 1000);
                db = openDatabase(shortName, version, displayName, maxSize);
                db.transaction(
                    function (transaction) {
                        console.log(AttendeeId);
                        transaction.executeSql('select tbl_Message.id as messageid,tbl_Message.messagedate,tbl_Message.fromid,tbl_Message.toid,tbl_Message.messsagetext,tbl_Message.fromname,tbl_Message.toname,tbl_Message.sendertype from tbl_Message  where flag = "false" and toid = ?', [AttendeeId], function (transaction, results) {
                            $('#messageList').empty();
                            if (results.rows.length === 0) {
                                $('#messageList').empty();
                                $('#messageList').listview('refresh');
                            }
                            else {
                                for (i = 0; i < results.rows.length; i++) {
                                    renderSponsorTodoUnreadMessages(results.rows.item(i));
                                }
                            }
                        });
                    }
                 );
            } catch (e) {
            }

        }
        function renderSponsorTodoUnreadMessages(row) {
            try {
                var ID, Message, Dateteime, From, Title, FirstName, LastName, Fromid, Toid;
                ID = row.id;
                Message = row.messsagetext;
                Dateteime = row.messagedate;
                Title = row.Title;
                From = row.fromname;
                console.log(From);
                if (row.messsagetext === null || row.messsagetext === "")
                { Message = ""; }
                else
                { Message = row.messsagetext; }
                if (row.messagedate === null || row.messagedate === "")
                { Dateteime = ""; }
                else
                { Dateteime = row.messagedate; }
                if (row.fromid === null || row.fromid === "")
                { Fromid = ""; }
                else
                { Fromid = row.fromid; }
                if (row.toid === null || row.toid === "")
                { Toid = ""; }
                else
                { Toid = row.toid; }
                $('#messageList').append(
                     '<li>' +
                      '<div style="float:right; padding-top:70px ">' +
                        '<a data-theme="a" data-role="button" href="#" onclick="sendReplyToAttendee(' + Fromid + ',' + Toid + ',\'' + From + '\')"; style="text-align:center"">Reply</a>' +
                        '<a data-theme="b" data-role="button" href="#" onclick="ReceivedMessageDelete(' + row.messageid + ')"; style="text-align:center"">Delete</a>' +
                      '</div>' +
                     ' <div style="height:200px; "> ' +
                        '<h3 style="color:blue;" class="ui-li-heading">From:</h3>' +
                        '<h3 class="ui-li-heading">' + From + '</h3>' +
                        '<h4 style="color:blue;" class="ui-li-heading">Date:</h4>' +
                        '<p class="ui-li-desc">' + Dateteime + '</p>' +
                        '<h4 style="color:blue;" class="ui-li-heading">Message:</h4>' +
                        '<p class="ui-li-desc">' + Message + '<br />' +
                        '</div>' +
                   ' </li>'
                 );
                $('#messageList').listview('refresh');
                $('#messageList a[data-role=button]').button();
            }
            catch (e) {
            }
        }
        function sendReplyToAttendee(fromID, toID, From) {
            $('#toAttendeeId').val(fromID);
            $('#messageToAttendeeHead').html('Message to <br />' + From);
            showAttendeeMessageDialog();
            GetReceivedMessages();
        }
        function ReceivedMessageDelete(ID) {
            if (navigator.onLine) {
                PageMethods.DeleteReceivedMessage(ID, onSucess, onError);
                function onSucess(result) {
                    try {
                        db = openDatabase(shortName, version, displayName, maxSize);
                        db.transaction(
                            function (transaction) {
                                transaction.executeSql('delete from tbl_Message where id = ?', [ID], function (transaction, results) {
                                    $().toastmessage('showToast', {
                                        text: 'Message Deleted !',
                                        sticky: false,
                                        position: 'top-right',
                                        type: 'success',
                                        closeText: '',
                                        close: function () {
                                        }
                                    });
                                });
                                GetReceivedMessages();
                            }
                         );
                    } catch (e) {
                        $.mobile.changePage("#Messages");
                    }
                }
                function onError(result) {
                    $().toastmessage('showToast', {
                        text: 'Unable to delete message ...',
                        sticky: false,
                        position: 'top-right',
                        type: 'error',
                        closeText: '',
                        close: function () {
                        }
                    });
                }
            }
            else {
                try {
                    db = openDatabase(shortName, version, displayName, maxSize);
                    db.transaction(
                        function (transaction) {
                            transaction.executeSql('delete from tbl_Message where id = ?', [ID], function (transaction, results) {
                                $().toastmessage('showToast', {
                                    text: 'Message Deleted !',
                                    sticky: false,
                                    position: 'top-right',
                                    type: 'success',
                                    closeText: '',
                                    close: function () {
                                    }
                                });
                            });
                            GetReceivedMessages();
                        }
                     );
                } catch (e) {
                    $.mobile.changePage("#Messages");
                }
            }
        }
        function showAttendeeMessageDialog() {
            $.mobile.changePage("#AttendeeMessage");
        }
        function showSpeakerMessageDialog() {
            $.mobile.changePage("#SpeakerMessage");
        }
        function showExhibitorMessageDialog() {
            $.mobile.changePage("#ExhibitorMessage");
        }
        function showSponsorMessageDialog() {
            $.mobile.changePage("#SponsorMessage");
        }

        function SendMessage() {
            var d = new Date,
               dformat = [d.getDate().padLeft(), (d.getMonth() + 1).padLeft(), d.getFullYear()].join('/') + ' ' + [d.getHours().padLeft(), d.getMinutes().padLeft(), d.getSeconds().padLeft()].join(':');
            try {
                messagetosend = $('#messageToAttendee').val();
                toattendeeId = $('#toAttendeeId').val();
                var fromname = localStorage.getItem("SenderName");
                var toname = localStorage.getItem("ReceiverName");
                if (typeof (messagetosend) === 'undefined' || messagetosend == "") {
                    $().toastmessage('showToast', {
                        text: 'cant send blank message ...',
                        sticky: false,
                        position: 'top-right',
                        type: 'success',
                        closeText: '',
                        close: function () {
                        }
                    });
                    $.mobile.changePage("#AttendeeMessage");
                }
                else {
                    db = openDatabase(shortName, version, displayName, maxSize);
                    db.transaction(
                        function (transaction) {
                            transaction.executeSql('insert into tbl_Message(fromid,toid,messsagetext,fromname,toname,messagedate,sendertype)values(?,?,?,?,?,?,?)', [AttendeeId, toattendeeId, messagetosend, fromname, toname, dformat, 1], function (transaction, results) {
                                $().toastmessage('showToast', {
                                    text: 'Message Sent Successfully...',
                                    sticky: false,
                                    position: 'top-right',
                                    type: 'success',
                                    closeText: '',
                                    close: function () {
                                    }
                                });
                            });
                            $('#messageToAttendee').val("");
                        }

                     );
                }

            } catch (e) { }
        }

        function SendExhibitorMessage() {
            var d = new Date,
               dformat = [d.getDate().padLeft(), (d.getMonth() + 1).padLeft(), d.getFullYear()].join('/') + ' ' + [d.getHours().padLeft(), d.getMinutes().padLeft(), d.getSeconds().padLeft()].join(':');
            try {
                var messagetosend = $('#messageToExhibitor').val();
                var toExhibitorId = $('#toExhibitorId').val();
                var fromname = localStorage.getItem("SenderName");
                var toname = localStorage.getItem("ReceiverName");
                if (typeof (messagetosend) === 'undefined' || messagetosend == "") {

                    $().toastmessage('showToast', {
                        text: 'cant send blank message ...',
                        sticky: false,
                        position: 'top-right',
                        type: 'success',
                        closeText: '',
                        close: function () {
                        }
                    });
                    $.mobile.changePage("#ExhibitorMessage");
                }
                else {

                    db = openDatabase(shortName, version, displayName, maxSize);
                    db.transaction(

                        function (transaction) {
                            transaction.executeSql('insert into tbl_Message(fromid,toid,messsagetext,fromname,toname,messagedate,sendertype)values(?,?,?,?,?,?,?)', [AttendeeId, toExhibitorId, messagetosend, fromname, toname, dformat, 2], function (transaction, results) {
                                $().toastmessage('showToast', {
                                    text: 'Message Sent Successfully...',
                                    sticky: false,
                                    position: 'top-right',
                                    type: 'success',
                                    closeText: '',
                                    close: function () {
                                    }
                                });
                                $('#messageToExhibitor').val("");
                            });
                        }

                     );
                }

            } catch (e) {
            }
        }

        function SendSpeakerMessage() {
            var d = new Date,
              dformat = [d.getDate().padLeft(), (d.getMonth() + 1).padLeft(), d.getFullYear()].join('/') + ' ' + [d.getHours().padLeft(), d.getMinutes().padLeft(), d.getSeconds().padLeft()].join(':');

            try {
                var messagetosend = $('#messageToSpeaker').val();
                var toSpeakerId = $('#toSpeakerId').val();
                var fromname = localStorage.getItem("SenderName");
                var toname = localStorage.getItem("ReceiverName");
                if (typeof (messagetosend) === 'undefined' || messagetosend == "") {

                    $().toastmessage('showToast', {
                        text: 'cant send blank message ...',
                        sticky: false,
                        position: 'top-right',
                        type: 'success',
                        closeText: '',
                        close: function () {
                        }
                    });
                    $.mobile.changePage("#SpeakerMessage");
                }
                else {

                    db = openDatabase(shortName, version, displayName, maxSize);
                    db.transaction(
                        function (transaction) {
                            transaction.executeSql('insert into tbl_Message(fromid,toid,messsagetext,fromname,toname,messagedate,sendertype)values(?,?,?,?,?,?,?)', [AttendeeId, toSpeakerId, messagetosend, fromname, toname, dformat, 3], function (transaction, results) {

                                $().toastmessage('showToast', {
                                    text: 'Message Sent Successfully...',
                                    sticky: false,
                                    position: 'top-right',
                                    type: 'success',
                                    closeText: '',
                                    close: function () {
                                    }
                                });
                                $('#messageToSpeaker').val("");
                            });
                        }
                     );
                }
            } catch (e) {
            }
        }

        function SendSponsorMessage() {
            var d = new Date,
                dformat = [d.getDate().padLeft(), (d.getMonth() + 1).padLeft(), d.getFullYear()].join('/') + ' ' + [d.getHours().padLeft(), d.getMinutes().padLeft(), d.getSeconds().padLeft()].join(':');

            try {
                var messagetosend = $('#messageToSponsor').val();
                var toSpeakerId = $('#toSponsorId').val();

                var fromname = localStorage.getItem("SenderName");
                var toname = localStorage.getItem("ReceiverName");

                if (typeof (messagetosend) === 'undefined' || messagetosend == "") {
                    $().toastmessage('showToast', {
                        text: 'cant send blank message ...',
                        sticky: false,
                        position: 'top-right',
                        type: 'success',
                        closeText: '',
                        close: function () {
                        }
                    });
                    $.mobile.changePage("#SponsorMessage");
                }
                else {

                    db = openDatabase(shortName, version, displayName, maxSize);
                    db.transaction(
                        function (transaction) {
                            transaction.executeSql('insert into tbl_Message(fromid,toid,messsagetext,fromname,toname,messagedate,sendertype)values(?,?,?,?,?,?,?)', [AttendeeId, toSpeakerId, messagetosend, fromname, toname, dformat, 4], function (transaction, results) {
                                $().toastmessage('showToast', {
                                    text: 'Message Sent Successfully...',
                                    sticky: false,
                                    position: 'top-right',
                                    type: 'success',
                                    closeText: '',
                                    close: function () {
                                    }
                                });
                                $('#messageToSponsor').val("");
                            });
                        }
                     );
                }
            } catch (e) {
            }
        }


        function GetSentSpeakerMessages() {
            try {
                db = openDatabase(shortName, version, displayName, maxSize);
                db.transaction(
                    function (transaction) {
                        transaction.executeSql('select tbl_Message.id as messageid,tbl_Message.id as messageid,tbl_Message.messagedate,tbl_Message.messsagetext,tbl_Speaker.id,tbl_Speaker.Title,tbl_Speaker.Firstname,tbl_Speaker.Lastname from tbl_Message,tbl_Speaker where tbl_Message.fromid = tbl_Speaker.id and flag = "false" and tbl_Message.fromid = ?', [AttendeeId], function (transaction, results) {
                            $('#messageList').empty();
                            if (results.rows.length != 0) {
                                for (i = 0; i < results.rows.length; i++) {
                                    renderSpeakerSent(results.rows.item(i));
                                }
                            }
                        });
                    }
                 );
            } catch (e) {
            }

        }
        function GetSentSpeakerMessages() {
            try {
                db = openDatabase(shortName, version, displayName, maxSize);
                db.transaction(
                    function (transaction) {
                        transaction.executeSql('select tbl_Message.id as messageid,tbl_Message.id as messageid,tbl_Message.messagedate,tbl_Message.messsagetext,tbl_Speaker.id,tbl_Speaker.Title,tbl_Speaker.Firstname,tbl_Speaker.Lastname from tbl_Message,tbl_Speaker where tbl_Message.fromid = tbl_Speaker.id and flag = "false" and tbl_Message.fromid = ?', [AttendeeId], function (transaction, results) {
                            $('#messageList').empty();
                            if (results.rows.length != 0) {
                                for (i = 0; i < results.rows.length; i++) {
                                    renderSpeakerSent(results.rows.item(i));
                                }
                            }
                        });
                    }
                 );
            } catch (e) {
            }

        }
        function renderSpeakerSent(row) {
            try {

                var ID, Message, Dateteime, From, Title, FirstName, LastName;

                ID = row.id;
                Message = row.messsagetext;
                Dateteime = row.messagedate;
                Title = row.title;
                FirstName = row.firstname;
                LastName = row.lastname;
                if (row.messsagetext === null || row.messsagetext === "")
                { Message = ""; }
                else
                { Message = row.messsagetext; }
                if (row.messagedate === null || row.messagedate === "")
                { Dateteime = ""; }
                else
                { Dateteime = row.messagedate; }
                if (row.title === null || row.title === "")
                { Title = ""; }
                else
                { Title = row.title; }
                if (row.Title === null || row.title === "")
                { Title = ""; }
                else
                { FirstName = row.FirstName; }
                if (row.firstname === null || row.firstname === "")
                { FirstName = ""; }
                else
                { FirstName = row.firstname; }
                if (row.lastname === null || row.lastname === "")
                { LastName = ""; }
                else
                { LastName = row.lastname; }
                From = Title + ' ' + FirstName + ' ' + LastName;
                $('#messageList').append(
                 '<li>' +
                      '<div style="float:right; padding-top:70px ">' +

                        '<a data-theme="a" data-role="button" href="#" onclick="SpeakerSentMessageReply(' + row.messageid + ')"; style="text-align:center"">Reply</a>' +
                        '<a data-theme="b" data-role="button" href="#" onclick="SpeakerSentMessageDelete(' + row.messageid + ')"; style="text-align:center"">Delete</a>' +
                      '</div>' +
                     ' <div style="height:200px; "> ' +
                        '<h3 style="color:blue;" class="ui-li-heading">To:</h3>' +
                        '<h3 class="ui-li-heading">' + From + '</h3>' +
                        '<h4 style="color:blue;" class="ui-li-heading">Date:</h4>' +
                        '<p class="ui-li-desc">' + Dateteime + '</p>' +
                        '<h4 style="color:blue;" class="ui-li-heading">Message:</h4>' +
                        '<p class="ui-li-desc">' + Message + '<br />' +
                        '</div>' +
                   ' </li>'
                 );
                $('#messageList').listview('refresh');
                $('#messageList a[data-role=button]').button();
            }
            catch (e) {
            }
        }


        function SpeakerSentMessageDelete(ID) {
            if (navigator.onLine) {
                PageMethods.DeleteReceivedSpeakerMessage(ID, onSucess, onError);
                function onSucess(result) {
                    try {
                        db = openDatabase(shortName, version, displayName, maxSize);
                        db.transaction(
                            function (transaction) {
                                transaction.executeSql('delete from tbl_Message where id = ?', [ID], function (transaction, results) {
                                    $().toastmessage('showToast', {
                                        text: 'Message Deleted !',
                                        sticky: false,
                                        position: 'top-right',
                                        type: 'success',
                                        closeText: '',
                                        close: function () {
                                        }
                                    });
                                });
                                GetReceivedMessages();
                            }
                         );
                    } catch (e) {
                        $.mobile.changePage("#Messages");
                    }
                }
                function onError(result) {
                    $().toastmessage('showToast', {
                        text: 'Unable to delete message ...',
                        sticky: false,
                        position: 'top-right',
                        type: 'error',
                        closeText: '',
                        close: function () {

                        }
                    });
                }
            }
            else {
                try {
                    db = openDatabase(shortName, version, displayName, maxSize);
                    db.transaction(
                        function (transaction) {
                            transaction.executeSql('delete from tbl_Message where id = ?', [ID], function (transaction, results) {
                                $().toastmessage('showToast', {
                                    text: 'Message Deleted !',
                                    sticky: false,
                                    position: 'top-right',
                                    type: 'success',
                                    closeText: '',
                                    close: function () {
                                    }
                                });
                            });
                            GetReceivedMessages();
                        }
                     );
                } catch (e) {
                    $.mobile.changePage("#Messages");
                }
            }
        }

        function GetSentMessages() {
            try {

                window.setTimeout(function () {
                    MessageToServer();
                    MessageFromServer();
                }, 1000);

                db = openDatabase(shortName, version, displayName, maxSize);
                db.transaction(
                    function (transaction) {
                        transaction.executeSql('select tbl_Message.id as messageid,tbl_Message.messagedate,tbl_Message.fromname,tbl_Message.toname,tbl_Message.sendertype,tbl_Message.messsagetext  from tbl_Message  where flag = "false" and fromid = ?', [AttendeeId], function (transaction, results) {
                            $('#messageList').empty();
                            if (results.rows.length === 0) {
                                $('#messageList').empty();
                                $('#messageList').listview('refresh');
                            }
                            else {
                                for (i = 0; i < results.rows.length; i++) {
                                    renderAttendeeSent(results.rows.item(i));
                                }
                            }
                        });
                    }
                 );
            } catch (e) {
            }

        }
        function renderAttendeeSent(row) {
            try {

                var ID, Message, Dateteime, FromName, Title, FirstName, LastName, ToName;

                ID = row.id;
                Message = row.messsagetext;
                Dateteime = row.messagedate;
                Title = row.Title;
                FromName = row.fromname;
                ToName = row.toname;
                if (row.messsagetext === null || row.messsagetext === "")
                { Message = ""; }
                else
                { Message = row.messsagetext; }
                if (row.messagedate === null || row.messagedate === "")
                { Dateteime = ""; }
                else
                { Dateteime = row.messagedate; }
                $('#messageList').append(

                    ' <li>' +
                      '<div style="float:right; padding-top:70px ">' +
                        '<a data-theme="b" data-role="button" href="#" onclick="AttendeeSentMessageDelete(' + row.messageid + ')"; style="text-align:center"">Delete</a>' +
                         '</div>' +
                     ' <div style="height:200px; "> ' +
                        '<h3 style="color:blue;" class="ui-li-heading">To:</h3>' +
                        '<h3 class="ui-li-heading">' + ToName + '</h3>' +
                        '<h4 style="color:blue;" class="ui-li-heading">Date:</h4>' +
                        '<p class="ui-li-desc">' + Dateteime + '</p>' +
                        '<h4 style="color:blue;" class="ui-li-heading">Message:</h4>' +
                        '<p class="ui-li-desc">' + Message + '<br />' +
                        '</div>' +
                   ' </li>'

                 );
                $('#messageList').listview('refresh');
                $('#messageList a[data-role=button]').button();
            }
            catch (e) {
            }
        }

        function AttendeeSentMessageDelete(ID) {

            alert("Deleting Message in exhibitor..." + ID);


            if (navigator.onLine) {
                PageMethods.DeleteReceivedAttendeeMessage(ID, onSucess, onError);
                function onSucess(result) {
                    try {
                        db = openDatabase(shortName, version, displayName, maxSize);
                        db.transaction(
                            function (transaction) {
                                transaction.executeSql('delete from tbl_Message where id = ?', [ID], function (transaction, results) {
                                    $().toastmessage('showToast', {
                                        text: 'Message Deleted !',
                                        sticky: false,
                                        position: 'top-right',
                                        type: 'success',
                                        closeText: '',
                                        close: function () {
                                        }
                                    });
                                });
                                GetSentMessages();
                            }
                         );
                    } catch (e) {
                        $.mobile.changePage("#Messages");
                    }
                }
                function onError(result) {
                    $().toastmessage('showToast', {
                        text: 'Unable to delete message ...',
                        sticky: false,
                        position: 'top-right',
                        type: 'error',
                        closeText: '',
                        close: function () {
                        }
                    });
                }
            }
            else {
                try {
                    db = openDatabase(shortName, version, displayName, maxSize);
                    db.transaction(
                        function (transaction) {
                            transaction.executeSql('delete from tbl_Message where id = ?', [ID], function (transaction, results) {
                                $().toastmessage('showToast', {
                                    text: 'Message Deleted !',
                                    sticky: false,
                                    position: 'top-right',
                                    type: 'success',
                                    closeText: '',
                                    close: function () {
                                        console.log("toast is closed ...");
                                    }
                                });
                            });
                            GetSentMessages();
                        }
                     );
                } catch (e) {
                    $.mobile.changePage("#Messages");
                }
            }

        }
        function GetSentExhibitorMessages() {
            try {

                db = openDatabase(shortName, version, displayName, maxSize);
                db.transaction(

                    function (transaction) {
                        transaction.executeSql('select tbl_Message.id as messageid,  tbl_Message.messagedate,tbl_Message.messsagetext,tbl_Exhibitor.id,tbl_Exhibitor.contactname from tbl_Message inner join tbl_Exhibitor on tbl_Message.toid = tbl_Exhibitor.id where flag = "false" and fromid =?', [AttendeeId], function (transaction, results) {
                            $('#messageList').empty();
                            if (results.rows.length != 0) {

                                for (i = 0; i < results.rows.length; i++) {
                                    renderExhibitorSent(results.rows.item(i));
                                }
                            }
                        });
                    }
                 );
            } catch (e) {
            }

        }
        function renderExhibitorSent(row) {
            try {

                var ID, Message, Dateteime, From, Name;
                ID = row.id;
                Message = row.messsagetext;
                Dateteime = row.messagedate;
                Name = row.contactname;
                if (row.messsagetext === null || row.messsagetext === "")
                { Message = ""; }
                else
                { Message = row.messsagetext; }
                if (row.messagedate === null || row.messagedate === "")
                { Dateteime = ""; }
                else
                { Dateteime = row.messagedate; }

                if (row.contactname === null || row.contactname === "")
                { Name = ""; }
                else
                { Name = row.contactname; }
                $('#messageList').append(
                    ' <li>' +
                      '<div style="float:right; padding-top:70px ">' +
                         '<a data-theme="a" data-role="button" href="#" onclick="exibitorMessageReply(' + row.messageid + ')"; style="text-align:center"">Reply</a>' +
                        '<a data-theme="b" data-role="button" href="#" onclick="exibitorMessageDelete(' + row.messageid + ')"; style="text-align:center"">Delete</a>' +
                     '</div>' +
                     ' <div style="height:200px; "> ' +
                        '<h3 style="color:blue;" class="ui-li-heading">To:</h3>' +
                        '<h3 class="ui-li-heading">' + Name + '</h3>' +
                        '<h4 style="color:blue;" class="ui-li-heading">Date:</h4>' +
                        '<p class="ui-li-desc">' + Dateteime + '</p>' +
                        '<h4 style="color:blue;" class="ui-li-heading">Message:</h4>' +
                        '<p class="ui-li-desc">' + Message + '<br />' +
                        '</div>' +
                   ' </li>'

                 );
                $('#messageList').listview('refresh');
                $('#messageList a[data-role=button]').button();
            }
            catch (e) {
            }
        }

        function exibitorMessageDelete(ID) {

            alert("Deleting Message in exhibitor...");

        }

        function GoingForLivePoll() {
            if (navigator.onLine) {
                $('#livepollcontainer').hide();
                $('#divPoll').hide();
                localStorage.setItem("lastvistedpage", 'index.aspx#livepoll');
                $.mobile.changePage("#livepoll");
                var options = $("#sessionPick");
                $("#sessionPick").empty();
                options.append($("<option />").val("-1").text("Select Session From List"));
                db = openDatabase(shortName, version, displayName, maxSize);
                db.transaction(function (transaction) {
                    transaction.executeSql("SELECT * FROM tbl_Session where event_code='" + ecode + "'", [], function (transaction, results) {
                        if (results.rows.length != 0) {
                            for (var i = 0; i < results.rows.length; i++) {
                                options.append($("<option />").val(results.rows.item(i).id).text(results.rows.item(i).sessionTitle));

                            }
                        }
                    });
                }
                 );
            }
            else {
                $().toastmessage('showToast', {
                    text: 'Not available in Offline ...',
                    sticky: false,
                    position: 'top-right',
                    type: 'error',
                    closeText: '',
                    close: function () {
                    }
                });
            }
        }
        function showReceivedList() {
            $("#recieveList").css("display", "block");
            $("#sendList").css("display", "none");
            $('#messageList').empty();
        }
        function showSendList() {
            $("#sendList").css("display", "block");
            $("#recieveList").css("display", "none");
            $('#messageList').empty();
        }
        function ShowHelp() {
            $().toastmessage('showToast', {
                text: 'Still Under Construction ...',
                sticky: false,
                position: 'top-right',
                type: 'warning',
                closeText: '',
                close: function () {
                }
            });
        }

        function setValue() {
            var usertype = localStorage.getItem("UserType");
            var AttendeeId = localStorage.getItem("AttendeeId");
            $("#UserId").val(AttendeeId);
            $("#UserType").val(usertype);
        }

    </script>

</head>
<body>
    <form id="form1" runat="server" enctype="multipart/form-data">
        <asp:UpdatePanel ID="PnlCompanyEdit" runat="server" ChildrenAsTriggers="true"
            UpdateMode="Always">
            <ContentTemplate>
                <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="true"></asp:ScriptManager>
                <asp:UpdateProgress ID="UpdateProgress1" runat="server"
                    AssociatedUpdatePanelID="PnlCompanyEdit">
                    <ProgressTemplate>
                        <img src="images/loading.gif" />
                        Please Wait ....
                    </ProgressTemplate>
                </asp:UpdateProgress>
                <div data-role="page" id="splash" class="container" style="text-align: center">
                    <img src="images/loading.gif" alt="splash" />
                </div>
                <!--Control Screen-->
                <div data-role="page" id="home">
                    <div data-role="header" data-position="fixed">
                        <h1>Login</h1>
                    </div>
                    <div class="flow_chart">
                        <div class="mag_textbox">
                            <label for="name" class="label_fix">Username</label>
                            <input type="text" id="txtecode" onkeypress="return runScript(event)" />
                        </div>
                    </div>
                    <div class="flow_chart">
                        <div class="mag_textbox">
                            <label for="name" class="label_fix">Password</label>
                            <input type="password" id="txtucode" onkeypress="return runScript(event)" />
                        </div>
                    </div>

                    <div class="flow_chart left_chart">
                        <div class="left">

                            <input id="btnlogin" data-inline="true" data-mini="true" type="button" value="Login" />

                        </div>
                    </div>
                    <div data-role="footer" data-position="fixed">
                        <h4 style="margin: 0px; padding: 0px">
                            <img src="images/acecqa-banner.jpg" border="0"></h4>
                    </div>
                </div>
                <div data-role="page" id="sync">
                    <div data-role="header" data-position="fixed">
                        <a href="#" data-role="button" data-inline="true" onclick="removeCredentials();" data-icon="minus">Log Out</a>

                        <h1>Select Event</h1>
                        <a href="#" onclick="getRefresh();" data-icon="refresh">Refresh</a>

                    </div>
                    <div class="flow_chart2">
                        <div id="choicediv" data-demo-html="true" style="margin-top: 20px; visibility: hidden;">
                            <ul id="eventChoiceList" data-role="listview" data-inset="true">
                            </ul>
                        </div>
                    </div>
                    <div data-role="footer" data-position="fixed">
                        <h4 style="margin: 0px; padding: 0px">
                            <img src="images/acecqa-banner.jpg" border="0"></h4>
                    </div>
                </div>
                <div data-role="page" id="cpanel">
                    <div data-role="header" data-position="fixed">
                        <a href="#" data-role="button" data-inline="true" onclick="removeCredentials();" data-icon="minus">Log Out</a>
                        <h3>
                            <span style="font-size: 10px;" id="cpanelHeader" runat="server"></span>
                        </h3>
                        <a href="#" onclick="getRefresh();" data-icon="refresh">Refresh</a>
                    </div>
                    <div class="flow_chart2">
                        <div>
                            <ul data-role="listview" data-split-icon="gear" data-split-theme="d" data-inset="true">
                                <li class="listex"><a href="#" onclick=" GetCheckInAvailable();">
                                    <img src="images/checking.png" class="ui-li-thumb" border="0" /><h4 class="ui-li-heading" id="checkinheader">Check In</h4>
                                </a></li>
                                <li class="listex"><a href="#Attendee">
                                    <img src="images/attendee.png" class="ui-li-thumb" border="0" /><h4 class="ui-li-heading">Attendees</h4>
                                </a></li>
                                <li class="listex"><a href="#sponsor">
                                    <img src="images/sponsor.png" class="ui-li-thumb" border="0" /><h4 class="ui-li-heading">Sponsors</h4>
                                </a></li>
                                <li class="listex"><a href="#speaker">
                                    <img src="images/speaker.png" class="ui-li-thumb" border="0" /><h4 class="ui-li-heading">Speakers</h4>
                                </a></li>
                                <li class="listex"><a href="#Session">
                                    <img src="images/shedule.png" class="ui-li-thumb" border="0" /><h4 class="ui-li-heading">Sessions</h4>
                                </a></li>

                                <li class="listex"><a href="#Exhibitor">
                                    <img src="images/exhibitor.png" class="ui-li-thumb" border="0" /><h4 class="ui-li-heading">Exhibitors</h4>
                                </a></li>

                                <li class="listex"><a href="#gmap">
                                    <img src="images/map.png" class="ui-li-thumb" border="0" /><h4 class="ui-li-heading">Map</h4>
                                </a></li>
                                <li class="listex"><a href="#News">
                                    <img src="images/news.png" class="ui-li-thumb" border="0" /><h4 class="ui-li-heading">News</h4>
                                </a></li>
                                <li class="listex"><a href="#notification">
                                    <img src="images/notification.png" class="ui-li-thumb" border="0" /><h4 class="ui-li-heading">Notifications</h4>
                                </a></li>
                                <li class="listex"><a href="#Messages">
                                    <img src="images/messages.png" class="ui-li-thumb" border="0" /><h4 class="ui-li-heading">Messages</h4>
                                </a></li>
                                <li class="listex"><a href="#PersonalSchedule">
                                    <img src="images/personal_shedule.png" class="ui-li-thumb" border="0" /><h4 class="ui-li-heading">Favourites List</h4>
                                </a></li>
                                <li class="listex"><a href="#EventEvaluation">
                                    <img src="images/evaluation.png" class="ui-li-thumb" border="0" /><h4 class="ui-li-heading">Event Evaluation</h4>
                                </a></li>
                                <li class="listex">
                                    <a href="#" onclick="GoingForLivePoll()">
                                        <img src="images/survey_icon.png" class="ui-li-thumb" border="0" /><h4 id="H13" class="ui-li-heading">Live Poll</h4>
                                    </a>
                                </li>
                                <li class="listex"><a href="#MyProfile">
                                    <img src="images/my_profile.png" class="ui-li-thumb" border="0" /><h4 class="ui-li-heading">My Profile</h4>
                                </a></li>
                                <li class="listex"><a href="[[ url ]]" id="twitterLink" target="_blank">
                                    <img src="images/twitter.png" class="ui-li-thumb" border="0" />
                                    <h4 class="ui-li-heading">Twitter</h4>
                                </a>
                                </li>
                                <li class="listex">
                                    <a href="otherfiles/Help.pdf" id="helpLink" target="_blank">
                                        <img src="images/HelpIcon.png" class="ui-li-thumb" border="0" />
                                        <h4 class="ui-li-heading">App User Guide</h4>
                                    </a>
                                </li>

                            </ul>
                        </div>
                    </div>
                    <div data-role="footer" data-position="fixed">
                        <h4 style="margin: 0px; padding: 0px">
                            <img src="images/acecqa-banner.jpg" border="0"></h4>
                    </div>
                </div>
                <div id="gmap" data-role="page">
                    <div data-role="header" data-position="fixed">
                        <h1>Map</h1>
                        <a href="#cpanel" data-role="button" data-inline="true">Back</a>
                        <a href="#map" data-role="button" data-inline="true">Next</a>
                    </div>
                    <div data-role="content">
                        <div class="ui-bar-c ui-corner-all ui-shadow" style="padding: 1em;">
                            <div id="map_canvas" style="height: 350px;"></div>
                        </div>
                    </div>
                    <div data-role="footer" data-position="fixed" class="footer">
                        <h4></h4>
                    </div>
                </div>
                <!--Main Screen-->
                <div data-role="page" id="Attendee">
                    <div data-role="header" data-position="fixed">
                        <a href="#cpanel" data-icon="back">Back</a>
                        <h1>Attendees</h1>
                        <a href="#cpanel" data-icon="home">Home</a>
                    </div>
                    <div class="flow_chart2">
                        <div data-demo-html="true" style="margin-top: 20px">
                            <ul id="attendeeList" data-role="listview" data-filter="true" data-inset="true">
                            </ul>
                        </div>
                    </div>
                    <div data-role="footer" data-position="fixed" class="footer">
                        <h4></h4>
                    </div>
                </div>
                <div data-role="page" id="notification">
                    <div data-role="header" data-position="fixed">
                        <a href="#cpanel" data-icon="back">Back</a>
                        <h1>Notification</h1>
                        <a href="#cpanel" data-icon="home">Home</a>
                    </div>
                    <div class="flow_chart2">
                        <div data-demo-html="true" style="margin-top: 20px">
                            <ul id="notificationList" data-role="listview" data-filter="true" data-inset="true">
                            </ul>
                        </div>
                    </div>
                    <div data-role="footer" data-position="fixed" class="footer">
                        <h4></h4>
                    </div>
                </div>
                <div data-role="page" id="Exhibitor">
                    <div data-role="header" data-position="fixed">
                        <a href="#cpanel" data-icon="back">Back</a>
                        <h1>Exhibitors</h1>
                        <a href="#cpanel" data-icon="home">Home</a>

                    </div>
                    <div class="flow_chart2">
                        <div data-demo-html="true" style="margin-top: 20px">
                            <ul id="exhibitorList" data-role="listview" data-filter="true" data-inset="true">
                            </ul>
                        </div>
                    </div>
                    <div data-role="footer" data-position="fixed" class="footer">
                        <h4></h4>
                    </div>
                </div>
                <div data-role="page" id="speaker">
                    <div data-role="header" data-position="fixed">
                        <a href="#cpanel" data-icon="back">Back</a>
                        <h1>Speakers</h1>
                        <a href="#cpanel" data-icon="home">Home</a>
                    </div>
                    <div class="flow_chart2">
                        <div data-demo-html="true" style="margin-top: 20px">
                            <ul id="speakerlist" data-role="listview" data-filter="true" data-inset="true">
                            </ul>
                        </div>
                    </div>
                    <div data-role="footer" data-position="fixed" class="footer">
                        <h4></h4>
                    </div>
                </div>
                <div data-role="page" id="sponsor">
                    <div data-role="header" data-position="fixed">
                        <a href="#cpanel" data-icon="back">Back</a>
                        <h1>Sponsors</h1>
                        <a href="#cpanel" data-icon="home">Home</a>
                    </div>
                    <div class="flow_chart2">
                        <div data-demo-html="true" style="margin-top: 20px">
                            <ul id="sponsorList" data-role="listview" data-filter="true" data-inset="true">
                            </ul>
                        </div>
                    </div>
                    <div data-role="footer" data-position="fixed" class="footer">
                        <h4></h4>
                    </div>
                </div>
                <div data-role="page" id="Events">
                    <div data-role="header" data-position="fixed">
                        <a href="#cpanel" data-icon="back">Back</a>
                        <h1>Events</h1>
                        <a href="#cpanel" data-icon="home">Home</a>
                    </div>
                    <div class="flow_chart2">
                        <div data-demo-html="true" style="margin-top: 20px">
                            <ul id="Eventlist" data-role="listview" data-filter="true" data-inset="true">
                            </ul>
                        </div>
                    </div>
                    <div data-role="footer" data-position="fixed" class="footer">
                        <h4></h4>
                    </div>
                </div>
                <div data-role="page" id="News">
                    <div data-role="header" data-position="fixed">
                        <a href="#cpanel" data-icon="back">Back</a>
                        <h1>News</h1>
                        <a href="#cpanel" data-icon="home">Home</a>
                    </div>
                    <div class="flow_chart2">
                        <div data-demo-html="true" style="margin-top: 0px">
                            <ul id="NewsList" data-role="listview" data-filter="true" data-inset="true">
                            </ul>
                        </div>
                    </div>
                    <div data-role="footer" data-position="fixed" class="footer">
                        <h4></h4>
                    </div>
                </div>
                <div data-role="page" id="Session">
                    <div data-role="header" data-position="fixed">
                        <a href="#cpanel" data-icon="back">Back</a>
                        <h1>Sessions</h1>
                        <a href="#cpanel" data-icon="home">Home</a>
                    </div>
                    <div class="flow_chart2">
                        <div data-demo-html="true" style="margin-top: 25px">
                            <ul id="SessionList" data-role="listview" data-filter="true" data-inset="true">
                            </ul>
                        </div>
                    </div>
                    <div data-role="footer" data-position="fixed" class="footer">
                        <h4></h4>
                    </div>
                </div>
                <div data-role="page" id="EventEvaluation">
                    <div data-role="header" data-position="fixed">
                        <a href="#cpanel" data-icon="back">Back</a>
                        <h1>Event Evaluation</h1>
                        <a href="#cpanel" data-icon="home">Home</a>
                    </div>
                    <div class="flow_chart2">
                        <div data-demo-html="true" style="margin-top: 20px">
                            <ul id="EventEvaluationList" data-role="listview" data-filter="true" data-inset="true">
                            </ul>
                        </div>
                    </div>
                    <div data-role="footer" data-position="fixed" class="footer">
                        <h4></h4>
                    </div>
                </div>
                <!--map Screen-->
                <div data-role="page" id="map">
                    <div data-role="header" data-position="fixed">
                        <h1>Map</h1>
                        <a href="#gmap" data-role="button" data-inline="true">Back</a>
                        <a href="#map1" data-role="button" data-inline="true">Next</a>
                    </div>
                    <a href="[[ url ]]" id="MainMapImageLink" target="_blank">
                        <div style="width: 100%; text-align: center;">
                            <img src="[[url]]" id="maimapimagetag" style="width: 100%; height: 100%">
                        </div>
                    </a>

                    <div data-role="footer" data-position="fixed" class="footer">
                        <h4></h4>
                    </div>

                </div>
                <div data-role="page" id="map1">
                    <div data-role="header" data-position="fixed">
                        <a href="#map" data-icon="back">Back</a>
                        <h1>Map 1 </h1>
                        <a href="#map2" data-icon="forward">Next</a>
                    </div>
                    <a href="[[ url ]]" id="MainMapImageLink1" target="_blank">
                        <div style="width: 100%; text-align: center;">
                            <img src="[[url]]" id="maimapimagetag1" style="width: 100%; height: 100%">
                        </div>
                    </a>



                    <div data-role="footer" data-position="fixed" class="footer">
                        <h4></h4>
                    </div>
                </div>
                <div data-role="page" id="map2">
                    <div data-role="header" data-position="fixed">
                        <a href="#map1" data-icon="back">Back</a>
                        <h1>Map 2</h1>
                        <a href="#map3" data-icon="forward">Next</a>
                    </div>
                    <a href="[[ url ]]" id="MainMapImageLink2" target="_blank">
                        <div style="width: 100%; text-align: center;">

                            <img src="[[url]]" id="maimapimagetag2" style="width: 100%; height: 100%">
                        </div>
                    </a>
                    <div data-role="footer" data-position="fixed" class="footer">
                        <h4></h4>
                    </div>
                </div>
                <div data-role="page" id="map3">
                    <div data-role="header" data-position="fixed">
                        <a href="#map2" data-icon="back">Back</a>
                        <h1>Map 3</h1>
                        <a href="#map4" data-icon="forward">Next</a>
                    </div>
                    <a href="[[ url ]]" id="MainMapImageLink3" target="_blank">
                        <div style="width: 100%; text-align: center;">
                            <img src="[[url]]" id="maimapimagetag3" style="width: 100%; height: 100%">
                        </div>
                    </a>
                    <div data-role="footer" data-position="fixed" class="footer">
                        <h4></h4>
                    </div>
                </div>
                <div data-role="page" id="map4">
                    <div data-role="header" data-position="fixed">
                        <a href="#map3" data-icon="back">Back</a>
                        <h1>Map 4</h1>
                        <a href="#map" data-icon="forward">Home</a>
                    </div>
                    <a href="[[ url ]]" id="MainMapImageLink4" target="_blank">
                        <div style="width: 100%; text-align: center;">
                            <img src="[[url]]" id="maimapimagetag4" style="width: 100%; height: 100%">
                        </div>
                    </a>
                    <div data-role="footer" data-position="fixed" class="footer">
                        <h4></h4>
                    </div>
                </div>
                <!--Details Screen-->
                <div id="eventEvalQuestions" data-role="page">
                    <div data-role="header" data-position="fixed">
                        <a href="#EventEvaluation" data-icon="back">Back</a>
                        <h1>Event Evaluation  </h1>
                        <a href="#cpanel" data-icon="home">Home</a>
                    </div>
                    <div class="flow_chart2">
                        <div class="flow_chart">
                            <div data-demo-html="true" style="margin-top: 20px">
                                <h1 id="questiontoshow"></h1>
                                <input type="hidden" id="eevalquestionid" name="questionId" />
                                <fieldset data-role="controlgroup" data-type="vertical">
                                    <legend>Rate Your Overall Satisfaction</legend>
                                    <input type="radio" name="radio-view" id="radio-view-a" value="1" />
                                    <label for="radio-view-a" style="font-size: smaller">Very Satisfied</label>
                                    <input type="radio" name="radio-view" id="radio-view-b" value="2" />
                                    <label for="radio-view-b" style="font-size: smaller">Satisfied</label>
                                    <input type="radio" name="radio-view" id="radio-view-c" value="3" />
                                    <label for="radio-view-c" style="font-size: smaller">Neutral</label>
                                    <input type="radio" name="radio-view" id="radio-view-d" value="4" />
                                    <label for="radio-view-d" style="font-size: smaller">Unsatisfied</label>
                                    <input type="radio" name="radio-view" id="radio-view-e" value="5" />
                                    <label for="radio-view-e" style="font-size: smaller">Very Unsatisfied</label>
                                </fieldset>
                                <a href="#" data-role="button" style="display: block" id="btnSubmitAnsEEval">Submit</a>
                            </div>
                        </div>
                    </div>
                    <div data-role="footer" data-position="fixed" class="footer">
                        <h4></h4>
                    </div>
                </div>
                <div data-role="page" id="sessionDetails">
                    <div data-role="header" data-position="fixed">
                        <a href="#Session" data-icon="back">Back</a>
                        <h1 id="H7">Session Details</h1>
                        <a href="#cpanel" data-icon="home">Home</a>
                    </div>
                    <div class="flow_chart2">
                        <input type="hidden" id="sessionhiddenid" name="sessionhiddenid" />
                        <div class="img_fixed"></div>
                        <div class="flow_chart">
                            <div class="mag_textbox">
                                <label for="name" class="label_fix"><b>Session Name</b></label>
                                <input type="text" id="txtSessionName" value="" />
                            </div>
                            <div class="mag_textbox">
                                <label for="name" class="label_fix"><b>Location</b></label>
                                <input type="text" id="txtSessionLocation" value="" />

                            </div>
                            <div class="mag_textbox">
                                <label for="name" class="label_fix"><b>Session Speaker</b></label>
                                <input type="text" id="txtsessionSpeaker" value="" />
                            </div>
                            <div class="mag_textbox">
                                <label for="name" class="label_fix"><b>Session Date</b></label>
                                <input type="text" id="txtsessionDate" value="" />
                            </div>

                            <div class="mag_textbox">
                                <label for="name" class="label_fix"><b>Session Start Time</b></label>
                                <input type="text" id="txtsessionstarttime" value="" />
                            </div>
                            <div class="mag_textbox">
                                <label for="name" class="label_fix"><b>Session Finish Time</b></label>
                                <input type="text" id="txtsessionfinishtime" value="" />
                            </div>
                            <div class="mag_textbox position_se">
                                <label for="name" class="label_fix"><b>Overview</b></label>
                                <textarea name="textarea" id="txtSessionOverview" style="height: 350px">
                        </textarea>
                            </div>
                        </div>
                        <div class="flow_chart set_action">
                            <a id="btnSessionFavsaveNew" runat="server" href="#" data-role="button" data-mini="true">Set Favourite</a>
                        </div>

                    </div>
                    <div data-role="footer" data-position="fixed" class="footer">
                        <h4></h4>
                    </div>
                </div>
                <div data-role="page" id="favsessionDetails">
                    <div data-role="header" data-position="fixed">
                        <a href="#FavSession" data-icon="back">Back</a>
                        <h1 id="H11">Session Details</h1>
                        <a href="#cpanel" data-icon="home">Home</a>
                    </div>
                    <div class="flow_chart2">
                        <input type="hidden" id="sessionhiddenidfav" name="sessionhiddenid" />
                        <div class="img_fixed"></div>
                        <div class="flow_chart">
                            <div class="mag_textbox">
                                <label for="name" class="label_fix"><b>Session Name</b></label>
                                <input type="text" id="txtSessionNamefav" value="" />
                            </div>
                            <div class="mag_textbox">
                                <label for="name" class="label_fix"><b>Location</b></label>
                                <input type="text" id="txtSessionLocationfav" value="" />

                            </div>
                            <div class="mag_textbox">
                                <label for="name" class="label_fix"><b>Session Speaker</b></label>
                                <input type="text" id="txtsessionSpeakerfav" value="" />
                            </div>
                            <div class="mag_textbox">
                                <label for="name" class="label_fix"><b>Session Start Time</b></label>
                                <input type="text" id="txtsessionstarttimefav" value="" />
                            </div>
                            <div class="mag_textbox">
                                <label for="name" class="label_fix"><b>Session Finish Time</b></label>
                                <input type="text" id="txtsessionfinishtimeFav" value="" />
                            </div>
                            <div class="mag_textbox position_se">
                                <label for="name" class="label_fix"><b>Overview</b></label>
                                <textarea name="textarea" id="txtSessionOverviewFav" style="height: 350px">
                        </textarea>
                            </div>
                            <div class="mag_textbox">
                                <label for="name" class="label_fix"><b>Session Note if any</b></label>
                                <input type="text" id="txtSessionNoteFav" value="" />
                            </div>
                        </div>
                        <div class="flow_chart set_action">
                            <a id="btnSessionUnFavsaveNew" runat="server" href="#" data-role="button" data-mini="true">Set unfavourite</a>
                        </div>
                    </div>
                    <div data-role="footer" data-position="fixed" class="footer">
                        <h4></h4>
                    </div>
                </div>
                <!--Session from speaker -->
                <div data-role="page" id="Speakersessions">
                    <div data-role="header" data-position="fixed">
                        <a href="#speaker" data-icon="back">Back</a>
                        <h1 id="H12">Session Details</h1>
                        <a href="#cpanel" data-icon="home">Home</a>
                    </div>
                    <div class="flow_chart2">
                        <input type="hidden" id="sessionhiddenidfavofsession" name="sessionhiddenid" />
                        <div class="img_fixed"></div>
                        <div class="flow_chart">
                            <div class="mag_textbox">
                                <label for="name" class="label_fix"><b>Session Name</b></label>
                                <input type="text" id="txtSessionNamefavofsession" value="" />
                            </div>
                            <div class="mag_textbox">
                                <label for="name" class="label_fix"><b>Location</b></label>
                                <input type="text" id="txtSessionLocationfavofsession" value="" />

                            </div>
                            <div class="mag_textbox">
                                <label for="name" class="label_fix"><b>Session Speaker</b></label>
                                <input type="text" id="txtsessionSpeakerfavofsession" value="" />
                            </div>
                            <div class="mag_textbox">
                                <label for="name" class="label_fix"><b>Session Start Time</b></label>
                                <input type="text" id="txtsessionstarttimefavofsession" value="" />
                            </div>
                            <div class="mag_textbox">
                                <label for="name" class="label_fix"><b>Session Finish Time</b></label>
                                <input type="text" id="txtsessionfinishtimeFavofsession" value="" />
                            </div>
                            <div class="mag_textbox position_se">
                                <label for="name" class="label_fix"><b>Overview</b></label>
                                <textarea name="textarea" id="txtSessionOverviewFavofsession" style="height: 350px">
                        </textarea>
                            </div>
                            <div class="mag_textbox">
                                <label for="name" class="label_fix"><b>Session Note if any</b></label>
                                <input type="text" id="txtSessionNoteFavofsession" value="" />
                            </div>
                        </div>
                    </div>
                    <div data-role="footer" data-position="fixed" class="footer">
                        <h4></h4>
                    </div>
                </div>
                <div data-role="page" id="eventDetails">
                    <div data-role="header" data-position="fixed">
                        <a href="#Events" data-icon="back">Back</a>
                        <h1 id="H5">Event Details</h1>
                        <a href="#cpanel" data-icon="home">Home</a>
                    </div>
                    <div class="flow_chart2">
                        <input type="hidden" id="eventhiddenid" name="eventhiddenid" />
                        <div class="img_fixed">
                            <img id="mapeventImage" src="[[url]]" class="profile_image">
                        </div>
                        <div class="flow_chart">
                            <div class="mag_textbox">
                                <label for="name" class="label_fix"><b>Event Name</b></label>
                                <input type="text" id="txtEventname" value="" />
                            </div>
                            <div class="mag_textbox">
                                <label for="name" class="label_fix"><b>Event Date</b></label>
                                <input type="text" id="txtEventDate" value="" />

                            </div>
                            <div class="mag_textbox">
                                <label for="name" class="label_fix"><b>Event Start Time</b></label>
                                <input type="text" id="txtEventStarttime" value="" />
                            </div>
                            <div class="mag_textbox">
                                <label for="name" class="label_fix"><b>Event Finish Time</b></label>
                                <input type="text" id="txtEventEndTime" value="" />
                            </div>

                        </div>
                    </div>
                    <div data-role="footer" data-position="fixed" class="footer">
                        <h4></h4>
                    </div>
                </div>
                <div data-role="page" id="AttendeeDetails">
                    <div data-role="header" data-position="fixed">
                        <a href="#Attendee" data-icon="back">Back</a>
                        <h1 id="attendeeHeader">Attendee Details</h1>
                        <a href="#cpanel" data-icon="home">Home</a>
                    </div>
                    <div class="flow_chart2">
                        <input type="hidden" id="AttendeeHiddenId" name="AttendeeHiddenId" />
                        <div class="img_fixed">
                            <img id="AttendeeImage" src="[[url]]" class="profile_image">
                        </div>
                        <div class="flow_chart">
                            <div class="mag_textbox">
                                <label for="name" class="label_fix"><b>Name</b></label>
                                <input type="text" id="Attendeename" value="" />
                            </div>
                            <div class="mag_textbox">
                                <label for="name" class="label_fix"><b>Company</b></label>
                                <input type="text" id="AttendeeCompany" value="" />

                            </div>
                            <div class="mag_textbox">
                                <label for="name" class="label_fix"><b>Category</b></label>
                                <input type="text" id="txtCategory" value="" />
                            </div>

                            <div class="mag_textbox">
                                <label for="name" class="label_fix"><b>Position</b></label>
                                <input type="text" id="AttendeePosition" value="" />
                            </div>
                            <div class="mag_textbox">
                                <label for="name" class="label_fix"><b>Email</b></label>
                                <input type="text" id="AttendeetxtEmail" value="" />
                            </div>
                            <div class="mag_textbox">
                                <label for="name" class="label_fix"><b>Phone</b></label>
                                <%--<input type="text" id="AttendeetxtPhoneno" value="" />      --%> 
                                <div id="callAttendee"></div>                         
                            </div>
                            <div class="mag_textbox">
                                <label for="name" class="label_fix"><b>Address</b></label>
                                <input type="text" id="AttendeetxtAddress" value="" />
                            </div>

                            <div class="mag_textbox">
                                <label for="name" class="label_fix"><b>Website</b></label>
                                <div id="AttendeeWeblink1"></div>
                            </div>
                            <div class="mag_textbox position_se">
                                <label for="name" class="label_fix"><b>Biography</b></label>
                                <textarea name="textarea" id="txtBioGrapghy" style="height: 350px">

                        </textarea>
                            </div>
                            <div>
                                
                                <span><a href="[[ url ]]" id="twitterlinkAttendee" target="_blank">
                                    <img src="images/icon-twitter.png" /></a></span>
                                <span><a href="[[ url ]]" id="linkedinlinkAttendee" target="_blank">
                                    <img src="images/icon-in.png" /></a></span>
                                <span><a href="[[ url ]]" id="fblinkAttendee" target="_blank">
                                    <img src="images/icon-fb.png" /></a></span>

                            </div>
                        </div>
                        <div class="flow_chart set_action">
                            <a id="btnAttendeeFaveNew" runat="server" href="#" data-role="button" data-mini="true">Set Favourite</a>
                            <a id="btnAttendeeConnectNew" onclick="showAttendeeMessageDialog();" runat="server" href="#" data-role="button" data-mini="true">Connect</a>
                        </div>
                    </div>
                    <div data-role="footer" data-position="fixed" class="footer">
                        <h4></h4>
                    </div>
                </div>
                <div data-role="page" id="AttendeeDetailsFav">
                    <div data-role="header" data-position="fixed">
                        <a href="#FavAttendee" data-icon="back">Back</a>
                        <h1 id="H10">Attendee Details</h1>
                        <a href="#cpanel" data-icon="home">Home</a>
                    </div>
                    <div class="flow_chart2">
                        <input type="hidden" id="AttendeeHiddenIdFav" name="AttendeeHiddenId" />
                        <div class="img_fixed">
                            <img id="AttendeeImageFav" src="[[url]]" class="profile_image">
                        </div>
                        <div class="flow_chart">
                            <div class="mag_textbox">
                                <label for="name" class="label_fix"><b>Name</b></label>
                                <input type="text" id="Attendeenamefav" value="" />
                            </div>
                            <div class="mag_textbox">
                                <label for="name" class="label_fix"><b>Company</b></label>
                                <input type="text" id="AttendeeCompanyfav" value="" />

                            </div>
                            <div class="mag_textbox">
                                <label for="name" class="label_fix"><b>Category</b></label>
                                <input type="text" id="txtCategoryfav" value="" />
                            </div>
                            <div class="mag_textbox">
                                <label for="name" class="label_fix"><b>Website</b></label>
                                <div id="AttendeeWeblink2"></div>
                            </div>
                            <div class="mag_textbox position_se">
                                <label for="name" class="label_fix"><b>Biography</b></label>
                                <textarea name="textarea" id="txtBioGrapghyfav" style="height: 350px">

                             </textarea>
                            </div>
                            <div>

                                <span><a href="[[ url ]]" id="twitterlinkattendeefav" target="_blank">
                                    <img src="images/icon-twitter.png" /></a></span>
                                <span><a href="[[ url ]]" id="linkedlinkattendeefav" target="_blank">
                                    <img src="images/icon-in.png" /></a></span>
                                <span><a href="[[ url ]]" id="fblinkattendeefav" target="_blank">
                                    <img src="images/icon-fb.png" /></a></span>


                            </div>
                        </div>
                        <div class="flow_chart set_action">
                            <a id="btnAttendeeUnfavNew" runat="server" href="#" data-role="button" data-mini="true">Set unfavourite</a>
                        </div>
                    </div>
                    <div data-role="footer" data-position="fixed" class="footer">
                        <h4></h4>
                    </div>
                </div>
                <div data-role="page" id="newsDetails">
                    <div data-role="header" data-position="fixed">
                        <a href="#News" data-icon="back">Back</a>
                        <h1 id="H6">News Details</h1>
                        <a href="#cpanel" data-icon="home">Home</a>
                    </div>

                    <input type="hidden" id="newshiddenid" name="newshiddenid" />
                    <div class="img_fixed">
                        <a href="[[url]]" id="newsimagelink" target="_blank">
                            <img id="newsImage" src="[[url]]" style='width: 60%; border: 1px solid black;'></a>
                    </div>
                    <div class="flow_chart2">
                        <div class="flow_chart">
                            <div class="mag_textbox">
                                <label for="name" class="label_fix"><b>News</b></label>
                                <input type="text" id="txtNewsTitle" value="" />
                            </div>
                            <div class="mag_textbox">
                                <label for="name" class="label_fix"><b>Date</b></label>
                                <input type="text" id="txtNewsDate" value="" />

                            </div>
                            <div class="mag_textbox">
                                <label for="name" class="label_fix"><b>Time</b></label>
                                <input type="text" id="txtNewstime" value="" />
                            </div>
                            <div class="mag_textbox">
                                <label for="name" class="label_fix"><b>Sent by</b></label>
                                <input type="text" id="txtAuthor" value="" />
                            </div>
                            <div class="mag_textbox position_se">
                                <label for="name" class="label_fix"><b>Description</b></label>
                                <textarea name="textarea" id="txtNewsdiscrip" style="height: 350px">
        </textarea>
                            </div>
                        </div>
                    </div>
                    <div data-role="footer" data-position="fixed" class="footer">
                        <h4></h4>
                    </div>
                </div>
                <div data-role="page" id="ExhibitorDetails">
                    <div data-role="header" data-position="fixed">
                        <a href="#Exhibitor" data-icon="back">Back</a>
                        <h1 id="H1">Exhibitor Details</h1>
                        <a href="#cpanel" data-icon="home">Home</a>
                    </div>
                    <div class="flow_chart2">
                        <input type="hidden" id="exhibitorhiddenid" name="exhibitorhiddenid" />
                        <div class="img_fixed">
                            <img id="ExhibitorImage" src="[[url]]" class="profile_image">
                        </div>
                        <div>
                            <span><a href="[[url]]" id="exhibitortwitterlink" target="_blank">
                                <img src="images/icon-twitter.png" /></a></span>
                            <span><a href="[[url]]" id="exhibitorlinkedinlink" target="_blank">
                                <img src="images/icon-in.png" /></a></span>
                            <span><a href="[[url]]" id="exhibitorfacebooklink" target="_blank">
                                <img src="images/icon-fb.png" /></a></span>
                        </div>
                        <div class="flow_chart">
                            <div class="mag_textbox">
                                <label for="name" class="label_fix"><b>Company</b></label>
                                <input type="text" id="txtExhiCompName" value="" />

                            </div>
                            <div class="mag_textbox">
                                <label for="name" class="label_fix"><b>Stand No <a id="exhiMapLink" href="[[link]]" > (Show on map) </a></b></label>                                
                                <input type="text" id="txtExhiStandNo" value="" />
                            </div>
                            <div class="mag_textbox">
                                <label for="name" class="label_fix"><b>Category</b></label>
                                <input type="text" id="txtExhiCatName" value="" />
                            </div>

                            <div class="mag_textbox">
                                <label for="name" class="label_fix"><b>Company Address</b></label>
                                <input type="text" id="txtExhiAddress" value="" />
                            </div>

                            <div class="mag_textbox">
                                <label for="name" class="label_fix"><b>Company Phone</b></label>
                                <input type="text" id="txtExhiPhone" value="" />
                            </div>


                            <div class="mag_textbox">
                                <label for="name" class="label_fix"><b>Website</b></label>
                                <div id="exhiWebLink2"></div>
                            </div>

                            <div class="mag_textbox">
                                <label for="name" class="label_fix"><b>Pesrson Name</b></label>
                                <input type="text" id="txtExhiName" value="" />
                            </div>

                            <div class="mag_textbox">
                                <label for="name" class="label_fix"><b>Contact Email</b></label>
                                <input type="text" id="txtExhiEmail" value="" />
                            </div>
                            <div class="mag_textbox">
                                <label for="name" class="label_fix"><b>Position</b></label>
                                <input type="text" id="txtExhiPosition" value="" />
                            </div>

                            <div class="mag_textbox position_se">
                                <label for="name" class="label_fix"><b>Biography</b></label>
                                <textarea name="textarea" id="txtExhiBio" style="height: 350px"></textarea>
                            </div>
                                                 
                        </div>
                        <div class="flow_chart set_action">
                            <a id="btnExhibitorFavsaveNew" runat="server" href="#" data-mini="true" data-role="button">Set Favourite</a>
                            <a id="btnExhibitorConnect" onclick="showExhibitorMessageDialog()" runat="server" href="#" data-mini="true" data-role="button">Connect</a>
                        </div>
                    </div>
                    <div data-role="footer" data-position="fixed" class="footer">
                        <h4></h4>
                    </div>
                </div>
                <div data-role="page" id="FavExhiDetails">
                    <div data-role="header" data-position="fixed">
                        <a href="#FavExhibitor" data-icon="back">Back</a>
                        <h1 id="H9"></h1>
                        <a href="#cpanel" data-icon="home">Home</a>
                    </div>
                    <div class="flow_chart2">
                        <input type="hidden" id="exhibitorhiddenidFav" name="exhibitorhiddenid" />
                        <div class="img_fixed">
                            <img id="ExhibitorImagefav" src="[[url]]" class="profile_image">
                        </div>
                        <div class="flow_chart">
                            <div class="mag_textbox">
                                <label for="name" class="label_fix"><b>Name</b></label>
                                <input type="text" id="txtExhiNamefav" value="" />
                            </div>
                            <div class="mag_textbox">
                                <label for="name" class="label_fix"><b>Company</b></label>
                                <input type="text" id="txtExhiCompNameFav" value="" />

                            </div>
                            <div class="mag_textbox">
                                <label for="name" class="label_fix"><b>Position</b></label>
                                <input type="text" id="txtExhiPositionFav" value="" />
                            </div>
                            <div class="mag_textbox">
                                <label for="name" class="label_fix"><b>Category</b></label>
                                <input type="text" id="txtExhiCatNameFav" value="" />
                            </div>
                            <div class="mag_textbox">
                                <label for="name" class="label_fix"><b>Website</b></label>
                                <div id="exhiWebLink1"></div>
                            </div>
                            <div class="mag_textbox">
                                <label for="name" class="label_fix"><b>Email</b></label>
                                <input type="text" id="txtExhiEmailFav" value="" />
                            </div>
                            <div class="mag_textbox">
                                <label for="name" class="label_fix"><b>Phone</b></label>
                                <input type="text" id="txtExhiPhoneFav" value="" />
                            </div>
                            <div class="mag_textbox">
                                <label for="name" class="label_fix"><b>Address</b></label>
                                <input type="text" id="txtExhiAddressFav" value="" />
                            </div>

                            <div class="mag_textbox position_se">
                                <label for="name" class="label_fix"><b>Biography</b></label>
                                <textarea name="textarea" id="txtExhiBioFav" style="height: 350px">

        </textarea>
                            </div>

                            <div>

                                <span><a href="[[ url ]]" id="exhibitortwitterlinkfav" target="_blank">
                                    <img src="images/icon-twitter.png" /></a></span>
                                <span><a href="[[ url ]]" id="exhibitorlinkedinlinkfav" target="_blank">
                                    <img src="images/icon-in.png" /></a></span>
                                <span><a href="[[ url ]]" id="exhibitorfacebooklinkfav" target="_blank">
                                    <img src="images/icon-fb.png" /></a></span>


                            </div>

                        </div>
                        <div class="flow_chart set_action">
                            <a id="btnExhibitorUnFavsaveNew" runat="server" href="#" data-mini="true" data-role="button">Set Unfavourite</a>
                        </div>
                    </div>
                    <div data-role="footer" data-position="fixed" class="footer">
                        <h4></h4>
                    </div>
                </div>
                <!--Favorite Screen-->

                 <div data-role="page" id="ExhiMap">

                    <div data-role="header" data-position="fixed">
                        <h1>Exhibitor Map</h1>
                        <a href="#ExhibitorDetails" data-icon="back">Back</a>
                        <a href="#cpanel" data-icon="home">Home</a>
                    </div>
                    <div style="width: 100%; text-align: center;">                       
                        <asp:Image ID="exihimapimg" ImageUrl="[[url]]" runat="server" CssClass="ExhiMapImag" />
                    </div>
                    <div data-role="footer" data-position="fixed" class="footer">
                        <h4></h4>
                    </div>
                </div>



                <div data-role="page" id="FavAttendee" onfocus="getPersonnalFavoriteCounts();">

                    <div data-role="header" data-position="fixed">
                        <h1>Favorite Attendee</h1>
                        <a href="#PersonalSchedule" data-icon="back">Back</a>
                        <a href="#cpanel" data-icon="home">Home</a>
                    </div>
                    <div data-demo-html="true" style="margin-top: 20px">
                        <ul data-role="listview" id="listfavAttendee" data-filter="true">
                        </ul>
                    </div>
                    <div data-role="footer" data-position="fixed" class="footer">
                        <h4></h4>
                    </div>
                </div>
                <div data-role="page" id="FavExhibitor">
                    <div data-role="header" data-position="fixed">
                        <h1>Favorite Exhibitor</h1>
                        <a href="#PersonalSchedule" data-icon="back">Back</a>
                        <a href="#cpanel" data-icon="home">Home</a>
                    </div>




                    <div class="flow_chart2">

                        <div data-demo-html="true" style="margin-top: 20px">
                            <ul data-role="listview" id="listfavExhi" data-inset="false" data-theme="c" data-filter="true" data-filter-placeholder="Search" data-dividertheme="d">
                                <li data-role="list-divider"></li>
                            </ul>
                        </div>


                    </div>
                    <div data-role="footer" data-position="fixed" class="footer">
                        <h4></h4>
                    </div>
                </div>
                <div data-role="page" id="FavSpeaker">

                    <div data-role="header" data-position="fixed">
                        <h1>Favorite Speaker</h1>
                        <a href="#PersonalSchedule" data-icon="back">Back</a>
                        <a href="#cpanel" data-icon="home">Home</a>
                    </div>
                    <div class="flow_chart2">

                        <div data-demo-html="true" style="margin-top: 20px">
                            <ul data-role="listview" id="speakerFavlist" data-inset="false" data-theme="c" data-filter="true" data-filter-placeholder="Search" data-dividertheme="d">
                                <li data-role="list-divider"></li>
                            </ul>
                        </div>
                    </div>
                    <div data-role="footer" data-position="fixed" class="footer">
                        <h4></h4>
                    </div>
                </div>
                <div data-role="page" id="FavSession">
                    <div data-role="header" data-position="fixed">
                        <h1>Favourite  Session</h1>
                        <a href="#PersonalSchedule" data-icon="back">Back</a>
                        <a href="#cpanel" data-icon="back">Home</a>
                    </div>
                    <div class="flow_chart2">
                        <div data-demo-html="true" style="margin-top: 20px">
                            <ul data-role="listview" id="SessionListFav" data-inset="false" data-theme="c" data-filter="true" data-filter-placeholder="Search" data-dividertheme="d">
                                <li data-role="list-divider"></li>
                            </ul>
                        </div>
                    </div>
                    <div data-role="footer" data-position="fixed">
                        <h4>ACECQA</h4>
                    </div>
                </div>
                <div data-role="page" id="SpeakerDetails">
                    <div data-role="header" data-position="fixed">
                        <a href="#speaker" data-icon="back">Back</a>
                        <h1 id="H3">Speaker Details</h1>
                        <a href="#cpanel" data-icon="home">Home</a>
                    </div>
                    <div class="flow_chart2">
                        <input type="hidden" id="speakerhiddenid" name="speakerhiddenid" />
                        <div class="img_fixed">
                            <img id="SpeakerImage" src="[[url]]" class="profile_image">
                        </div>
                        <div class="flow_chart">
                            <div class="mag_textbox">
                                <label for="name" class="label_fix"><b>Name</b></label>
                                <input type="text" id="txtSpeakerName" value="" />
                            </div>
                            <div class="mag_textbox">
                                <label for="name" class="label_fix"><b>Company</b></label>
                                <input type="text" id="txtSpeakerComp" value="" />
                            </div>
                            <div class="mag_textbox">
                                <label for="name" class="label_fix"><b>Category</b></label>
                                <input type="text" id="txtSpeakerCat" value="" />
                            </div>
                            <div class="mag_textbox">
                                <label for="name" class="label_fix"><b>Position</b></label>
                                <input type="text" id="txtSpeakerposition" value="" />
                            </div>
                            <div class="mag_textbox">
                                <label for="name" class="label_fix"><b>Email</b></label>
                                <input type="text" id="txtSpeakeremail" value="" />
                            </div>
                            <div class="mag_textbox">
                                <label for="name" class="label_fix"><b>Phone</b></label>
                                <input type="text" id="txtSpeakerphone" value="" />
                            </div>
                            <div class="mag_textbox">
                                <label for="name" class="label_fix"><b>Address</b></label>
                                <input type="text" id="txtSpeakeraddress" value="" />
                            </div>
                            <div class="mag_textbox">
                                <label for="name" class="label_fix"><b>Website</b></label>
                                <div id="SpeakerLink1"></div>
                            </div>
                            <div class="mag_textbox position_se">
                                <label for="name" class="label_fix"><b>Biography</b></label>
                                <textarea name="textarea" id="txtSpeakerBio" style="height: 350px"></textarea>
                            </div>
                            <div>
                                <span><a href="[[ url ]]" id="speakertwitterlink" target="_blank">
                                    <img src="images/icon-twitter.png" /></a></span>
                                <span><a href="[[ url ]]" id="speakerlinkedinlink" target="_blank">
                                    <img src="images/icon-in.png" /></a></span>
                                <span><a href="[[ url ]]" id="speakerfacebooklink" target="_blank">
                                    <img src="images/icon-fb.png" /></a></span>
                            </div>
                            <div class="mag_textbox">
                                <label for="name" class="label_fix"><b>His/Her Sessions</b></label>
                                <ul data-role="listview" id="SpeakerToSessionList" data-theme="d" data-inset="true">
                                </ul>

                            </div>
                        </div>
                        <div class="flow_chart set_action">
                            <a id="btnSpeakerFavNew" runat="server" href="#" data-role="button" data-mini="true">Set Favourite</a>
                            <a id="btnSpeakerConnect" onclick="showSpeakerMessageDialog()" runat="server" href="#" data-mini="true" data-role="button">Connect</a>

                        </div>
                    </div>
                    <div data-role="footer" data-position="fixed" class="footer">
                        <h4></h4>
                    </div>
                </div>
                <div data-role="page" id="FavSpeakerDetails">
                    <div data-role="header" data-position="fixed">
                        <a href="#FavSpeaker" data-icon="back">Back</a>
                        <h1 id="H8">Speaker Details</h1>
                        <a href="#cpanel" data-icon="home">Home</a>
                    </div>
                    <div class="flow_chart2">
                        <input type="hidden" id="speakerhiddenidFav" name="speakerhiddenid" />
                        <div class="img_fixed">
                            <img id="SpeakerImagefav" src="[[url]]" class="profile_image">
                        </div>
                        <div class="flow_chart">
                            <div class="mag_textbox">
                                <label for="name" class="label_fix"><b>Name</b></label>
                                <input type="text" id="txtSpeakerNameFav" value="" />
                            </div>
                            <div class="mag_textbox">
                                <label for="name" class="label_fix"><b>Company</b></label>
                                <input type="text" id="txtSpeakerCompFav" value="" />

                            </div>
                            <div class="mag_textbox">
                                <label for="name" class="label_fix"><b>Category</b></label>
                                <input type="text" id="txtSpeakerCatFav" value="" />
                            </div>
                            <div class="mag_textbox">
                                <label for="name" class="label_fix"><b>Website</b></label>
                                <div id="SpeakerLink2"></div>
                            </div>
                            <div class="mag_textbox position_se">
                                <label for="name" class="label_fix"><b>Biography</b></label>
                                <textarea name="textarea" id="txtSpeakerBioFav" style="height: 350px">

                </textarea>
                            </div>
                            <div class="mag_textbox">
                                <span><a href="[[ url ]]" id="speakertwitterlinkfav" target="_blank">
                                    <img src="images/icon-twitter.png" /></a></span>
                                <span><a href="[[ url ]]" id="speakerlinkedinlinkfav" target="_blank">
                                    <img src="images/icon-in.png" /></a></span>
                                <span><a href="[[ url ]]" id="speakerfacebooklinkfav" target="_blank">
                                    <img src="images/icon-fb.png" /></a></span>
                            </div>
                            <div class="mag_textbox">
                                <label for="name" class="label_fix"><b>His/Her Sessions</b></label>
                                <ul data-role="listview" id="SpeakerToSessionListFav" data-theme="d" data-inset="true">
                                </ul>

                            </div>



                        </div>
                        <div class="flow_chart set_action">
                            <a id="btnSpeakerUnFavNew" runat="server" href="#" data-role="button" data-mini="true">Un Favourite</a>

                        </div>
                    </div>
                    <div data-role="footer" data-position="fixed" class="footer">
                        <h4></h4>
                    </div>
                </div>
                <div data-role="page" id="sponsorDetails">
                    <div data-role="header" data-position="fixed">
                        <a href="#sponsor" data-icon="back">Back</a>
                        <h1 id="H4">Sponsor Details</h1>
                        <a href="#cpanel" data-icon="home">Home</a>
                    </div>
                    <div class="flow_chart2">
                        <div class="img_fixed">
                            <img id="sponsorImage" src="[[url]]" class="profile_image">
                        </div>
                        <div class="flow_chart">
                            <div class="mag_textbox">
                                <label for="name" class="label_fix"><b>Company Name</b></label>
                                <input type="text" id="txtSponName" value="" />
                            </div>

                            <div class="mag_textbox">
                                <label for="name" class="label_fix"><b>Phone</b></label>
                                <input type="text" id="txtsponsorphone" value="" />
                            </div>
                            <div class="mag_textbox">
                                <label for="name" class="label_fix"><b>Email</b></label>
                                <input type="text" id="txtsponsoremail" value="" />
                            </div>
                            <div class="mag_textbox">
                                <label for="name" class="label_fix"><b>Contact Name</b></label>
                                <input type="text" id="txtsponsorconatctname" value="" />
                            </div>
                            <div class="mag_textbox position_se">
                                <label for="name" class="label_fix"><b>Position</b></label>
                                <input type="text" id="txtsponposi" value="" />
                            </div>
                            <div class="mag_textbox position_se">
                                <label for="name" class="label_fix"><b>Address</b></label>
                                <input type="text" id="txtsponAddress" value="" />
                            </div>
                            <div class="mag_textbox position_se">
                                <label for="name" class="label_fix"><b>Description</b></label>
                                <textarea name="textarea" id="txtSponBio" style="height: 350px">
                        </textarea>
                            </div>
                            <div class="mag_textbox position_se">
                                <label for="name" class="label_fix"><b>Website</b></label>
                                <div id="sponsorwebLinks"></div>
                            </div>
                            <div class='mag_textbox position_se'>
                                <label for='name' class='label_fix'><b>Product & Service Link 1</b></label>
                                <div id="sponsorwebLinks1"></div>

                            </div>
                            <div class='mag_textbox position_se'>
                                <label for='name' class='label_fix'><b>Product & Service Link 2</b></label>
                                <div id="sponsorwebLinks2"></div>

                            </div>
                            <div class='mag_textbox position_se'>
                                <label for='name' class='label_fix'><b>Product & Service Link 3</b></label>
                                <div id="sponsorwebLinks3"></div>
                            </div>
                            <div class='mag_textbox position_se'>
                                <label for='name' class='label_fix'><b>Product & Service Link 4</b></label>
                                <div id="sponsorwebLinks4"></div>

                            </div>
                            <div class="flow_chart set_action">
                                <%--<a id="A1" runat="server" href="#" data-role="button" data-mini="true">Set Favourite</a>--%>
                                <a id="sponsorconnectbutton" onclick="showSponsorMessageDialog()" runat="server" href="#" data-mini="true" data-role="button">Connect</a>
                            </div>
                            <div class="mag_textbox">

                                <span><a href="[[ url ]]" id="sponsortwitterlink" target="_blank">
                                    <img src="images/icon-twitter.png" /></a></span>
                                <span><a href="[[ url ]]" id="sponsoryoutubelink" target="_blank">
                                    <img src="images/icon-in.png" /></a></span>
                                <span><a href="[[ url ]]" id="sponsorfacebooklink" target="_blank">
                                    <img src="images/icon-fb.png" /></a></span>
                            </div>
                        </div>

                    </div>
                    <div data-role="footer" data-position="fixed" class="footer">
                        <h4></h4>
                    </div>
                </div>
                <!--Miscellenious Screen-->
                <div data-role="page" id="MyProfile">
                    <div data-role="header" data-position="fixed">
                        <a href="#cpanel" data-icon="back">Back</a>
                        <h1>My Profile</h1>
                        <a href="#cpanel" data-icon="home">Home</a>
                    </div>
                    <div class="flow_chart2">
                        <div class="img_fixed">
                            <h4 style="margin: 0px; padding: 0px">
                                <asp:Image ID="profileImage" runat="server" src="[[url]]" CssClass="profile_image" border="0" />
                            </h4>
                        </div>

                        <div class="flow_chart">
                            <div class="mag_textbox" id="NameDiv">
                                <label for="name" class="label_fix"><b>Name</b></label>
                                <input type="text" id="txtMainName" runat="server" value="" />
                            </div>
                            <div class="mag_textbox" id="contactNameDiv">
                                <label for="name" class="label_fix"><b>Contact Name</b></label>
                                <input type="text" id="txtContactName" runat="server" value="" />
                            </div>
                            <div class="mag_textbox" id="nameTitleDiv">
                                <label for="name" class="label_fix"><b>Title</b></label>
                                <input type="text" id="txttitle" runat="server" value="" />
                            </div>
                            <div class="mag_textbox" id="fnameDiv">
                                <label for="name" class="label_fix"><b>First Name</b></label>
                                <input type="text" id="txtfname" runat="server" value="" />

                            </div>
                            <div class="mag_textbox" id="lnamediv">
                                <label for="name" class="label_fix"><b>Last Name</b></label>
                                <input type="text" id="txtlname" runat="server" value="" />
                            </div>
                            <div class="mag_textbox">
                                <label for="name" class="label_fix"><b>Position</b></label>
                                <input type="text" id="txtposition" runat="server" value="" />
                            </div>
                            <div class="mag_textbox">
                                <label for="name" class="label_fix"><b>Category</b></label>
                                <input type="text" id="txtpCategory" runat="server" value="" />
                            </div>
                            <div class="mag_textbox">
                                <label for="name" class="label_fix"><b>Address</b></label>
                                <input type="text" id="txtAddress" runat="server" value="" />
                            </div>
                            <div class="mag_textbox">
                                <label for="name" class="label_fix"><b>Phone</b></label>
                                <input type="text" id="txtPhone" runat="server" value="" />
                            </div>
                            <div class="mag_textbox">
                                <label for="name" class="label_fix"><b>Email</b></label>
                                <input type="text" id="txtEmailaddress" runat="server" value="" />
                            </div>
                            <div class="mag_textbox">
                                <label for="name" class="label_fix"><b>Company</b></label>
                                <input type="text" id="txtCompany" runat="server" value="" />
                            </div>
                            <div class="mag_textbox">
                                <label for="name" class="label_fix"><b>Website</b></label>
                                <div id="txtwebsite"></div>
                            </div>
                            <div class="mag_textbox">
                                <label for="name" class="label_fix"><b>Profile Link</b></label>
                                <div id="txtAdminProfile"></div>
                            </div>
                            <div class="mag_textbox position_se">
                                <label for="name" class="label_fix"><b>Biography</b></label>
                                <textarea name="textarea" id="txtbio" runat="server" style="height: 350px"> </textarea>
                            </div>
                            <div class="mag_textbox position_se">
                                <label for="name" class="label_fix"><b>Choose Profile Image</b></label>
                                <asp:FileUpload ID="FileUpload1" runat="server" />

                            </div>
                            <div class="mag_textbox"></div>


                        </div>
                        <div class="flow_chart set_action">
                            <asp:LinkButton ID="btnprofileSaveNew" runat="server" data-role="button" data-mini="true" OnClick="LinkButton1_Click" OnClientClick="setValue();">Save</asp:LinkButton>
                        </div>

                    </div>
                    <div data-role="footer" data-position="fixed" class="footer">
                        <h4></h4>
                    </div>
                </div>
                <div data-role="page" id="PersonalSchedule">
                    <div data-role="header" data-position="fixed">
                        <a href="#cpanel" data-icon="back">Back</a>
                        <h1>Personal Schedule</h1>
                        <a href="#cpanel" data-icon="home">Home</a>
                    </div>
                    <div class="flow_chart2">
                        <ul data-role="listview" id="personalScheduleList" data-filter="true">
                            <li class="listex1"><a href="#FavAttendee">
                                <h3 class="ui-li-heading">Attendee</h3>
                            </a>
                                <span id="Span1" class="ui-li-count"></span>
                            </li>

                            <li class="listex1"><a href="#FavExhibitor">
                                <h3 class="ui-li-heading">Exhibitor</h3>
                            </a>
                                <span id="Span2" class="ui-li-count"></span>
                            </li>

                            <li class="listex1"><a href="#FavSpeaker">
                                <h3 class="ui-li-heading">Speaker</h3>
                            </a>
                                <span id="Span3" class="ui-li-count"></span>
                            </li>

                            <li class="listex1"><a href="#FavSession">
                                <h3 class="ui-li-heading">Session</h3>
                            </a>
                                <span id="Span4" class="ui-li-count"></span>
                            </li>
                        </ul>
                    </div>
                    <div data-role="footer" data-position="fixed" class="footer">
                        <h4></h4>
                    </div>
                </div>
                <div data-role="page" id="instruction">
                    <header data-role="header" data-position="fixed">
                        <h1 id="H2" runat="server"></h1>
                    </header>
                    <div class="main" data-role="content">
                        <div class="container_p">
                            <div class="dial_box">Please Use Add To Home Screen on Previous Page</div>
                        </div>
                    </div>
                    <div data-role="footer" data-position="fixed" class="footer">
                        <h4></h4>
                    </div>
                </div>
                <div data-role="page" id="AppUpdateScreen">
                    <div data-role="header" data-position="fixed">
                        <h1>Update</h1>
                    </div>
                    <section data-role="content" style="text-align: center;">
                        Please Wait … … … … … Updating App!                         
                    </section>
                    <div data-role="footer" data-position="fixed" class="footer">
                        <h4></h4>
                    </div>
                </div>
                <div data-role="page" id="checkin">
                    <div data-role="header" data-position="fixed">
                        <h1></h1>
                        <a href="#cpanel" data-icon="back">Back</a>
                        <a href="#cpanel" data-icon="home">Home</a>
                    </div>
                    <section data-role="content" style="text-align: center;">
                        <span id="checkinStatement"></span>
                    </section>
                    <div data-role="footer" data-position="fixed" class="footer">
                        <h4></h4>
                    </div>
                </div>
                <div id="twitter" data-role="page">

                    <div data-role="header" data-position="fixed">
                        <a href="#cpanel" data-icon="back">Back</a>
                        <h1>Twitter</h1>
                        <a href="#cpanel" data-icon="home">Home</a>
                    </div>
                    <div class="flow_chart2">
                        <div class="flow_chart">
                            <span><a href="[[ url ]]" id="twitterLinkNew" target="_blank">
                                <img src="images/icon-twitter.png" /></a></span>
                        </div>
                    </div>
                    <div data-role="footer" data-position="fixed" class="footer">
                        <h4></h4>
                    </div>
                </div>
                <div id="livepoll" data-role="page">
                    <div data-role="header" data-position="fixed">
                        <a href="#cpanel" data-icon="back">Back</a>
                        <h1>Live Poll</h1>
                        <a href="#cpanel" data-icon="home">Home</a>
                    </div>

                    <div class="flow_chart2">
                        <div class="flow_chart">
                            <div data-demo-html="true" style="margin-top: 20px">
                                <div class="containing-element">

                                    <select name="IsActive" id="sessionPick" data-role="dropdownlist">
                                        <option value="-1">Select Session Form List</option>
                                    </select>
                                </div>

                                <div runat="server" id="divMsg" class="mInfo" visible="false" />
                                <div class="mag_textbox">
                                    <section data-role="content" style="text-align: center;">
                                        <asp:Label runat="server" class="label_fix" ID="sessionText" Text="Session has not started" />
                                    </section>

                                </div>
                                <div runat="server" class="form" id="livepollcontainer">

                                    <div class="mag_textbox">
                                        <asp:Label runat="server" class="label_fix" ID="lblEventCode" Text="" />
                                    </div>
                                    <div class="mag_textbox">
                                        <asp:Label runat="server" class="label_fix" ID="lblsession" Text="" />
                                    </div>
                                    <div id="divPoll" class="poll-box" runat="server">
                                        <div class="poll-question">
                                            <h3>
                                                <asp:Label runat="server" class="label_fix" ID="lblquestion" Text="" /></h3>
                                        </div>
                                        <div id="divAnswers" runat="server">
                                        </div>
                                        <input type="button" value="Vote" class="submit" id="btnSubmitVote" />
                                    </div>
                                </div>
                                <asp:HiddenField runat="server" ID="hidPollID" />
                                <asp:HiddenField runat="server" ID="hideventcode" />
                                <asp:HiddenField runat="server" ID="hidsessionid" />

                            </div>

                        </div>
                    </div>
                    <div data-role="footer" data-position="fixed" class="footer">
                        <h4></h4>
                    </div>
                </div>
                <!--Messages Screen-->
                <div id="Messages" data-role="page">
                    <div data-role="header" data-position="fixed">
                        <a href="#cpanel" data-icon="back">Back</a>
                        <h1>Messages</h1>
                        <a href="#cpanel" data-icon="home">Home</a>
                        <div data-role="navbar">
                            <ul>
                                <li>
                                    <a href="#" class="ui-btn-active ui-state-persist" onclick="GetReceivedMessages();">Inbox <span class="ui-li-count"></span></a>
                                </li>
                                <li>
                                    <a href="#" onclick="GetSentMessages();">Sent <span class="ui-li-count"></span></a>
                                </li>
                            </ul>
                        </div>
                    </div>
                    <div class="flow_chart2">
                        <div class="flow_chart">
                            <div data-demo-html="true" style="margin-top: 20px">
                                <ul data-role="listview" id="messageList" data-filter-placeholder="Search" data-inset="false" data-theme="c">
                                </ul>
                            </div>
                        </div>
                    </div>
                    <div data-role="footer" data-position="fixed" class="footer">
                        <h4></h4>
                    </div>
                </div>
                <div id="AttendeeMessage" data-role="dialog" data-title="Message" data-theme="b">
                    <div data-role="header" data-theme="e">
                        <h4 style="font-size: 12px" id="messageToAttendeeHead">Message To Attendee</h4>
                    </div>
                    <div data-role="content">
                        <input type="hidden" id="toAttendeeId" name="attendeeID" />
                        <input type="hidden" id="senderType1" name="attendeeID" />
                        <textarea id="messageToAttendee" style="height: 170px" rows="8" cols="2"></textarea>

                        <a href="#Attendee" data-rel="back" data-role="button" data-theme="a" id="btnSend" onclick="SendMessage()">Send</a>
                        <a href="#Attendee" data-rel="back" data-role="button" data-theme="a">Cancel</a>
                    </div>

                </div>
                <div id="ExhibitorMessage" data-role="dialog" data-title="Message" data-theme="b">
                    <div data-role="header" data-theme="e">
                        <h4 style="font-size: 12px" id="messageToExhibitorHead">Message To Exhibitor</h4>
                    </div>
                    <div data-role="content">
                        <input type="hidden" id="toExhibitorId" name="toExhibitorId" />
                        <input type="hidden" id="senderType2" name="attendeeID" />
                        <textarea id="messageToExhibitor" style="height: 170px" rows="8" cols="2"></textarea>
                        <a href="#Exhibitor" data-rel="back" data-role="button" data-theme="a" id="A2" onclick="SendExhibitorMessage()">Send</a>
                        <a href="#Exhibitor" data-rel="back" data-role="button" data-theme="a">Cancel</a>
                    </div>

                </div>
                <div id="SpeakerMessage" data-role="dialog" data-title="Message" data-theme="b">
                    <div data-role="header" data-theme="e">
                        <h4 style="font-size: 12px" id="messageToSpeakerHead">Message To Speaker</h4>
                    </div>
                    <div data-role="content">
                        <input type="hidden" id="toSpeakerId" name="toSpeakerId" />
                        <input type="hidden" id="senderType3" name="attendeeID" />
                        <textarea id="messageToSpeaker" style="height: 170px" rows="8" cols="2"></textarea>
                        <a href="#Attendee" data-rel="back" data-role="button" data-theme="a" id="A3" onclick="SendSpeakerMessage()">Send</a>
                        <a href="#Attendee" data-rel="back" data-role="button" data-theme="a">Cancel</a>
                    </div>

                </div>
                <div id="SponsorMessage" data-role="dialog" data-title="Message" data-theme="b">
                    <div data-role="header" data-theme="e">
                        <h4 style="font-size: 12px" id="messagetoSponsorHead">Message To Sponsor</h4>
                    </div>
                    <div data-role="content">
                        <input type="hidden" id="toSponsorId" name="toSponsorId" />
                        <input type="hidden" id="senderType4" name="attendeeID" />
                        <textarea id="messageToSponsor" style="height: 170px" rows="8" cols="2"></textarea>
                        <a href="#Attendee" data-rel="back" data-role="button" data-theme="a" id="A5" onclick="SendSponsorMessage()">Send</a>
                        <a href="#Attendee" data-rel="back" data-role="button" data-theme="a">Cancel</a>
                    </div>
                </div>
                <div>
                    <input type="hidden" id="UserId" runat="server" name="UId" />
                    <input type="hidden" id="UserType" runat="server" name="UType" />
                </div>
            </ContentTemplate>
            <Triggers>
                <asp:PostBackTrigger ControlID="btnprofileSaveNew" />
            </Triggers>
        </asp:UpdatePanel>
    </form>
</body>
</html>

