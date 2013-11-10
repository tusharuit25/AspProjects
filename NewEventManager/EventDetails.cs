using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace NewEventManager
{
    public class EventDetails
    {
        public EventDetails()
        {
            //
            // TODO: Add constructor logic here
            //
        }
        private string _eventCode;
        private string _companyName;
        private string _req_user_id;
        private string _user_contact_no;
        private string _useremail;
        private string _req_date;
        private string _event_name;
        private string _event_type;
        private string _event_level;
        private string _timezone;
        private string _event_start_date;
        private string _event_end_date;
        private string _event_start_time;
        private string _event_end_time;
        private string _MiMeType;
        private string _MiMeType_1;
        private string _MiMeType_2;
        private string _MiMeType_3;
        private string _MiMeType_4;
        private string _mapAPIkey;
        private decimal _latitude;
        private decimal _longitude;

       

        public string EventCode
        {
            get { return _eventCode; }
            set { _eventCode = value; }
        }


        public string Company
        {
            get { return _companyName; }
            set { _companyName = value; }
        }

        public string UserRequestId
        {
            get { return _req_user_id; }
            set { _req_user_id = value; }
        }

        public string UserContactNo
        {
            get { return _user_contact_no; }
            set { _user_contact_no = value; }
        }
        public string UserEmail
        {
            get { return _useremail; }
            set { _useremail = value; }
        }
        public string RequestDate
        {
            get { return _req_date; }
            set { _req_date = value; }
        }
        public string EventName
        {
            get { return _event_name; }
            set { _event_name = value; }
        }

        public string EventType
        {
            get { return _event_type; }
            set { _event_type = value; }
        }
        public string EventLevel
        {
            get { return _event_level; }
            set { _event_level = value; }

        }
        public string TimeZone
        {
            get { return _timezone; }
            set { _timezone = value; }
        }

        public string EventStartDate
        {
            get { return _event_start_date; }
            set { _event_start_date = value; }
        }
        public string EventEndDate
        {
            get { return _event_end_date; }
            set { _event_end_date = value; }
        }

        public string EventStartTime
        {
            get { return _event_start_time; }
            set { _event_start_time = value; }
        }
        public string EventEndTime
        {
            get { return _event_end_time; }
            set { _event_end_time = value; }
        }
        public string MIMEType
        {
            get { return _MiMeType; }
            set { _MiMeType = value; }
        }
        public string MIMEType1
        {
            get { return _MiMeType_1; }
            set { _MiMeType_1 = value; }
        }
        public string MIMEType2
        {
            get { return _MiMeType_2; }
            set { _MiMeType_2 = value; }
        }
        public string MIMEType3
        {
            get { return _MiMeType_3; }
            set { _MiMeType_3 = value; }
        }
        public string MIMEType4
        {
            get { return _MiMeType_4; }
            set { _MiMeType_4 = value; }
        }
        public string MapKey
        {
            get { return _mapAPIkey; }
            set { _mapAPIkey = value; }
        }
        public decimal Latitude
        {
            get { return _latitude; }
            set { _latitude = value; }
        }
        public decimal Longitude
        {
            get { return _longitude; }
            set { _longitude = value; }
        }       

        
    }
}