using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace NewEventManager
{
    public class SubscribedEvent
    {
        string event_code;
        string event_name;
        public SubscribedEvent()
        {
        }
        public string EventCode
        {
            get { return event_code; }
            set { event_code = value; }
        }
        public string EventName
        {
            get { return event_name; }
            set { event_name = value; }
        }
    }
}