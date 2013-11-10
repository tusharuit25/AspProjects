using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace NewEventManager
{
    public class EventQuestions
    {
        private int id, _sessionid;
        private String questionText;
        private String _event_code;
   
        public EventQuestions()
        {

        }
        public int Id
        {
            get { return id; }
            set { id = value; }
        }

        public string Question
        {
            get { return questionText; }
            set { questionText = value; }
        }
        public string EventCode
        {
            get { return _event_code; }
            set { _event_code = value; }
        }

        public int SessionId
        {
            get { return _sessionid; }
            set { _sessionid = value; }
        }

    }
}