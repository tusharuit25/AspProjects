using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace NewEventManager
{
    public class EventQuestionOptions
    {
        private int id,questionid;
        private String option1,option2,option3,option4;
        
        public EventQuestionOptions()
        {

        }
        public int Id
        {
            get { return id; }
            set { id = value; }
        }

        public int Questionid
        {
            get { return questionid; }
            set { questionid = value; }
        }
        public string Option1
        {
            get { return option1; }
            set { option1 = value; }
        }
        public string Option2
        {
            get { return option2; }
            set { option2 = value; }
        }
        public string Option3
        {
            get { return option3; }
            set { option3 = value; }
        }
        public string Option4
        {
            get { return option4; }
            set { option4 = value; }
        }

        
    }
}