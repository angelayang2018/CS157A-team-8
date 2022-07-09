$(document).ready(function(){
            $('.toggle').click(function(){
                $('.menu').toggleClass('active');
            });
        });
        
$('.message a').click(function(){
   $('form').animate({height: "toggle", opacity: "toggle"}, "slow");
});