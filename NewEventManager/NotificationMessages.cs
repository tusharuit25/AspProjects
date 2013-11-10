using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace NewEventManager
{
    public class NotificationMessages
    {
        private int _id;
        private string _message;
        private string _time;

        public NotificationMessages()
        {
            //
            // TODO: Add constructor logic here
            //
        }
        public int ID
        {
            get { return _id; }
            set { _id = value; }
        }
        public string Message
        {
            get { return _message; }
            set { _message = value; }
        }
        public string Time
        {
            get { return _time; }
            set { _time = value; }
        }

    }
}