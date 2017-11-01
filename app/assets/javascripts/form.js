(function ($, W, D)
  {
  var JQUERY4U = {};
  JQUERY4U.UTIL =
      {
          setupFormValidation: function ()
          {
          //form validation rules
          $("#myForm").validate({
              rules: {
              name: "required",
              url: {
                  required: true,
                  url: true
              },
              phone: {
                      required: true,
                       minlength: 10,
                       pattern: [/^[7-9]{1}[0-9]{9}$/], 
                  },
              email: {
                      required: true,
                      email: true
                  },
              code: {
                      required: true,
                      rangelength: [11, 11]
                  },
              min_length:{
                      required: true,
                      minlength: 3
                  },
              number: {
                  digits: true,
                  required:true,
                  minlength:5
                  }
              },
              messages: {
              name: "Please Enter Name",
              phone: "Please Enter Valid Mobile Number",
              email: "Please Enter valid Email",
              code: "Please Enter 11 Digit code",
              min_length:"Please Enter Minimum 3 Digit",
              number: "Please Enter Only Digits",
              url: "Please Enter Website Url"
              },
              submitHandler: function (form) {
              form.submit();
              }
          });
        }
      }
  //when the dom has loaded setup form validation rules
  $(D).ready(function ($) {
      JQUERY4U.UTIL.setupFormValidation();
  });
  })(jQuery, window, document);