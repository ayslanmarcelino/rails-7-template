// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"
import Swal from 'sweetalert2';
import '../../lib/assets/javascripts/confirm';

window.Swal = Swal;
