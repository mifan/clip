$(function(){
  $('#new_user').validate( {

    rules: {
      'user[login]': {
        required: true,
        minlength: 2
      },
      'user[email]': {
        required: true,
        email: true
      },
      'user[password]':  {
        required: true,
        minlength: 3
      }
    },

    messages: {
      'user[login]': '名号不能为空也不能太短哦！',
      'user[email]': '输入一个真的邮箱地址吧！',
      'user[password]': '密码不能为空也不能太短哦！'
    }

  });  //validate




  // notice login first
  $("li.frame > a").click(function(event){
    event.preventDefault();
    popupMessage("Please login first ... ");
  });  //click

}); //on load event
