$(function(){
  $('#new_user_session').validate( {

    rules: {
      'user_session[login]': {
        required: true,
        minlength: 2
      },
      'user_session[password]':  {
        required: true,
        minlength: 3
      }
    },

    messages: {
      'user_session[login]': '名号太短肯定不对！',
      'user_session[password]': '密码太短肯定不对！'
    }

  });  //validate




  // notice login first
  $("li.frame > a").click(function(event){
    event.preventDefault();
    popupMessage("Please login first ... ");
  });  //click

}); //on load event
