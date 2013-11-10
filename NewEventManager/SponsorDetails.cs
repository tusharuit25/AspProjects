using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace NewEventManager
{
    public class SponsorDetails
    {
        private int _id;
        private string _SponsorName;
        private string _eventCode;
        private string _Discription;
        private string _MIMEType;
        private string _product1;
        private string _product2;
        private string _product3;
        private string _product4;
        private string _product5;
        private string _facebook;
        private string _twitter;
        private string _youtube;
        private string _contactname;
        private string _phone;
        private string _email;
        private string _position;
        private string _address;
     
        private string _website;
        private string _adminlink;
        public string AdminLink
        {
            get { return _adminlink; }
            set { _adminlink = value; }
        }
        public string Website
        {
            get { return _website; }
            set { _website = value; }
        }
        public SponsorDetails()
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
        public string EventCode
        {
            get { return _eventCode; }
            set { _eventCode = value; }
        }
        public string SponsorName
        {
            get { return _SponsorName; }
            set { _SponsorName = value; }
        }

        public string Discription
        {
            get { return _Discription; }
            set { _Discription = value; }
        }

        public string MIMEType
        {
            get { return _MIMEType; }
            set { _MIMEType = value; }
        }

        public string Product1
        {
            get { return _product1; }
            set { _product1 = value; }
        }
        public string Product2
        {
            get { return _product2; }
            set { _product2 = value; }
        }

        public string Product3
        {
            get { return _product3; }
            set { _product3 = value; }
        }

        public string Product4
        {
            get { return _product4; }
            set { _product4 = value; }
        }


        public string Product5
        {
            get { return _product5; }
            set { _product5 = value; }
        }

        public string FacebookURL
        {
            get { return _facebook; }
            set { _facebook = value; }
        }

        public string YouTubeURL
        {
            get { return _youtube; }
            set { _youtube = value; }
        }


        public string TwitterURL
        {
            get { return _twitter; }
            set { _twitter = value; }
        }
        public string Contactname
        {
            get { return _contactname; }
            set { _contactname = value; }
        }
        public string Phone
        {
            get { return _phone; }
            set { _phone = value; }
        }
        public string Email
        {
            get { return _email; }
            set { _email = value; }
        }
        public string Position
        {
            get { return _position; }
            set { _position = value; }
        }
        public string Address
        {
            get { return _address; }
            set { _address = value; }
        }
     
    }
}