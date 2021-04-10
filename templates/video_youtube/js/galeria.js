$(document).ready(function(){
	$('.video-lista').css('height', $('.video-ver').height());
});

//cargar galeria
function crear_galeria(videos){

	var enlaces = videos.split(',');

		// obtener miniaturas
		for (var $i = 0; $i <= enlaces.length - 1; $i++) {
			
			// cargar primer vídeo
			if( $('iframe').attr('src') == '' ){
				var embed = enlaces[$i].split('watch?v=').join('embed/');
				$('.video-container iframe').attr('src',embed);
			}
			
				// obtener id del vídeo
				var idvideo =  enlaces[$i].split('watch?v=');

				// generar miniatura
				var miniatura = 'https://img.youtube.com/vi/' + idvideo[1] + '/maxresdefault.jpg'

				// generar titulo
				var titulo = '';
							
					//agregar lista de vídeos
					$('.video-lista ul').append('<li><img src="' + miniatura + '" id="' + idvideo[1] + '"></li>');
					
					//poner titulos a miniaturas
					generar_titulo(idvideo[1]);
			
		}


				//cambiar de vídeo
				$('.video-lista ul li img').click(function(){
				//Cambiar vídeo embed
				var nuevoembed = $(this).attr('id');
				$('.video-container iframe').attr('src', 'https://youtube.com/embed/' + nuevoembed);
				});

}

function generar_titulo(idvideo){

	$.ajax({
	url: "https://www.googleapis.com/youtube/v3/videos?key=AIzaSyCHxo3ehlWha1Cl6NuL8SW2PDgKhIXkJDs&part=snippet&id=" + idvideo,
	dataType: "jsonp",
	success: function (data) {
		
		if( data.items[0].snippet.title !='' ){
		titulo = data.items[0].snippet.title;
		$('#' + idvideo ).after('<span>' + titulo + '</span>');
						
		}
		
	}
	});	


}
