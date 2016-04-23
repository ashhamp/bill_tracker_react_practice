


$(function(){
  $('#sign-up-submit').click(function(event){
    event.preventDefault();

    var username = $('#user_username').val();
    var email = $('#user_email').val();
    var password = $('#user_password').val();
    var passwordConfirmation = $('#user_password_confirmation').val();
    signUp(username, email, password, passwordConfirmation);
  });
});

var signUp = function(username, email, password, passwordConfirmation) {
    var request = $.ajax({
      method: 'POST',
      url: '/users',
      beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
      dataType: 'json',
      data: {
        user: {
          username: username,
          email: email,
          password: password,
          password_confirmation: passwordConfirmation
        }
      }
    });
    request.done(function(data) {
      if (data.status === 200) {
        $('#signup-form').foundation('close');
         window.location.href = data.redirect;
      } else if (data.status === 500) {
        $('#signup-errors').html(data.errors);
      }
    });
  };

  $(function(){
    $('#form_close_signup').click(function(){
      $('#user_username').val('');
      $('#user_email').val('');
      $('#user_password').val('');
      $('#user_password_confirmation').val('');
      $('#signup-errors').html('')
    });
  });
