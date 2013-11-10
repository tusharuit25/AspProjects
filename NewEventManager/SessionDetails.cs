using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace NewEventManager
{
    public class SessionDetails
    {
        private int _sessionId;
        private string _eventCode;
        private string _Sessiontitle;
        private string _SessionDate;
        private string _sessionstarttime;
        private string _sessionfinishtime;
        private string _SesLocation;
        private string _Overview;
        private string _sessionSpeakerFirstName;
        private string _sessionSpeakerlastName;


        public SessionDetails()
        {
            //
            // TODO: Add constructor logic here
            //
        }
        public int ID
        {
            get { return _sessionId; }
            set { _sessionId = value; }
        }
        public string EventCode
        {
            get { return _eventCode; }
            set { _eventCode = value; }
        }


        public string SessiontTitle
        {
            get { return _Sessiontitle; }
            set { _Sessiontitle = value; }
        }

        public string SessionDate
        {
            get { return _SessionDate; }
            set { _SessionDate = value; }
        }

        public string SessionStartTime
        {
            get { return _sessionstarttime; }
            set { _sessionstarttime = value; }
        }
        public string SessionFinishTime
        {
            get { return _sessionfinishtime; }
            set { _sessionfinishtime = value; }
        }
        public string SessionLocation
        {
            get { return _SesLocation; }
            set { _SesLocation = value; }
        }
        public string Overview
        {
            get { return _Overview; }
            set { _Overview = value; }
        }

        public string SessionSpeakerFirstName
        {
            get { return _sessionSpeakerFirstName; }
            set { _sessionSpeakerFirstName = value; }
        }
        public string SessionSpeakerlastName
        {
            get { return _sessionSpeakerlastName; }
            set { _sessionSpeakerlastName = value; }
        }
    }
}