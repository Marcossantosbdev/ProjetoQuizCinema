/* Efeitos do site: campo de estrelas cintilantes + elementos que aparecem ao rolar a página */
(function () {
    'use strict';

    // ---- 1) Campo de estrelas (canvas) ----
    var canvas = document.getElementById('estrelas');
    if (canvas && canvas.getContext) {
        var ctx = canvas.getContext('2d');
        var estrelas = [];
        var reduzir = window.matchMedia && window.matchMedia('(prefers-reduced-motion: reduce)').matches;

        function redimensionar() {
            canvas.width = window.innerWidth;
            canvas.height = window.innerHeight;
            estrelas = [];
            var qtd = Math.min(220, Math.floor(canvas.width * canvas.height / 7000));
            for (var i = 0; i < qtd; i++) {
                estrelas.push({
                    x: Math.random() * canvas.width,
                    y: Math.random() * canvas.height,
                    r: Math.random() * 1.4 + 0.3,
                    fase: Math.random() * Math.PI * 2,
                    vel: Math.random() * 0.02 + 0.005
                });
            }
        }

        function desenhar() {
            ctx.clearRect(0, 0, canvas.width, canvas.height);
            for (var i = 0; i < estrelas.length; i++) {
                var e = estrelas[i];
                e.fase += e.vel;
                var brilho = 0.45 + 0.55 * Math.abs(Math.sin(e.fase));
                ctx.beginPath();
                ctx.arc(e.x, e.y, e.r, 0, Math.PI * 2);
                ctx.fillStyle = 'rgba(255,255,255,' + brilho.toFixed(2) + ')';
                ctx.fill();
            }
            if (!reduzir) {
                requestAnimationFrame(desenhar);
            }
        }

        window.addEventListener('resize', redimensionar);
        redimensionar();
        desenhar();
    }

    // ---- 2) Aparecer ao rolar a página ----
    var itens = document.querySelectorAll('.reveal');
    if ('IntersectionObserver' in window) {
        var obs = new IntersectionObserver(function (entradas) {
            entradas.forEach(function (en) {
                if (en.isIntersecting) {
                    en.target.classList.add('visivel');
                    obs.unobserve(en.target);
                }
            });
        }, { threshold: 0.15 });
        itens.forEach(function (el) { obs.observe(el); });
    } else {
        itens.forEach(function (el) { el.classList.add('visivel'); });
    }
})();
