document.addEventListener('DOMContentLoaded', function() {
    'use strict';

    const preloader = document.getElementById('preloader');
    const progressBar = document.querySelector('.preloader-bar-simple'); // Cần nếu muốn kiểm soát width bằng JS

    if (preloader) {
        console.log("main.js: Simple Bar Preloader element found.");

        window.addEventListener('load', function() {
            console.log("main.js: Window fully loaded. Initiating Simple Bar preloader hiding sequence.");

            // Cho animation chạy thêm một chút
            const hideDelay = 500; // 0.5 giây sau khi trang tải xong

            setTimeout(function() {
                preloader.classList.add('hiding'); // Kích hoạt transition mờ dần cho logo và thanh

                // Sau khi transition 'hiding' kết thúc (0.4s)
                setTimeout(function() {
                    preloader.classList.add('loaded'); // Ẩn hoàn toàn preloader
                    console.log("main.js: Preloader set to 'loaded'.");
                    if (typeof AOS !== 'undefined') {
                        AOS.refreshHard();
                    }
                }, 400);

            }, hideDelay);
        });

        // Fallback an toàn
        const fallbackTimeoutDuration = 8000;
        setTimeout(function() {
            if (!preloader.classList.contains('loaded')) {
                console.warn("main.js: Preloader fallback timeout. Forcing hide.");
                if (!preloader.classList.contains('hiding')) {
                    preloader.classList.add('hiding');
                    setTimeout(function() {
                        preloader.classList.add('loaded');
                        if (typeof AOS !== 'undefined') AOS.refreshHard();
                    }, 400);
                } else if (!preloader.classList.contains('loaded')) {
                    preloader.classList.add('loaded');
                    if (typeof AOS !== 'undefined') AOS.refreshHard();
                }
            }
        }, fallbackTimeoutDuration);

    } else {
        console.error("main.js: Preloader element NOT found!");
    }

    const header = document.querySelector('.header-area');
    if(header){
        window.addEventListener('scroll', function() {
            if (window.scrollY > 100) {
                header.classList.add('sticky');
            } else {
                header.classList.remove('sticky');
            }
        });
    }

    if (typeof AOS !== 'undefined') {
        AOS.init({
            duration: 1000,
            once: true,
            easing: 'ease-in-out'
        });
    }

    if (typeof gsap !== 'undefined' && typeof ScrollTrigger !== 'undefined') {
        if (document.querySelector('.hero-text')) {
            gsap.from('.hero-text h1', { y: 50, opacity: 0, duration: 1, delay: 0.5 });
            gsap.from('.hero-text p', { y: 50, opacity: 0, duration: 1, delay: 0.8 });
            gsap.from('.hero-text .hero-btn', { y: 50, opacity: 0, duration: 1, delay: 1.1, stagger: 0.2 });
        }

        gsap.utils.toArray('.section-title').forEach(title => {
            ScrollTrigger.create({
                trigger: title,
                start: "top 80%",
                onEnter: () => { gsap.fromTo(title, { y: 100, opacity: 0 }, { y: 0, opacity: 1, duration: 1 }); }
            });
        });

        gsap.utils.toArray('.feature-box').forEach((box, index) => {
            ScrollTrigger.create({
                trigger: box,
                start: "top 80%",
                onEnter: () => { gsap.fromTo(box, { y: 100, opacity: 0 }, { y: 0, opacity: 1, duration: 0.8, delay: index * 0.2 });}
            });
        });

        if (document.querySelector('.skill-progress-bar')) {
            const skillBars = document.querySelectorAll('.skill-progress-bar');
            ScrollTrigger.create({
                trigger: '.skills-area',
                start: "top 80%",
                onEnter: () => {
                    skillBars.forEach(skill => {
                        const percent = skill.getAttribute('data-progress');
                        if(percent){
                            gsap.to(skill, { width: percent, duration: 1.5, ease: "power3.out" });
                        }
                    });
                },
                onLeaveBack: () => {
                    skillBars.forEach(skill => {
                        gsap.to(skill, { width: '0%', duration: 0.5 });
                    });
                }
            });
        }

        if (document.querySelector('.timeline-item')) {
            gsap.utils.toArray('.timeline-item').forEach((item, index) => {
                ScrollTrigger.create({
                    trigger: item,
                    start: "top 80%",
                    onEnter: () => { gsap.fromTo(item, { opacity: 0, x: index % 2 === 0 ? -100 : 100 }, { opacity: 1, x: 0, duration: 1 });}
                });
            });
        }

        if (document.querySelector('.testimonial-item')) {
            gsap.utils.toArray('.testimonial-item').forEach((item, index) => {
                ScrollTrigger.create({
                    trigger: item,
                    start: "top 80%",
                    onEnter: () => { gsap.fromTo(item, { opacity: 0, y: 50 }, { opacity: 1, y: 0, duration: 0.8, delay: index * 0.2 });}
                });
            });
        }

        if (document.querySelector('.company-box')) {
            gsap.utils.toArray('.company-box').forEach((box) => {
                ScrollTrigger.create({
                    trigger: box,
                    start: "top 80%",
                    onEnter: () => { gsap.fromTo(box, { opacity: 0, y: 50 }, { opacity: 1, y: 0, duration: 0.8 });}
                });
            });
        }

        if (document.querySelector('.about-img') && document.querySelector('.about-content')) {
            ScrollTrigger.create({
                trigger: '.about-img',
                start: "top 80%",
                onEnter: () => { gsap.fromTo('.about-img', { opacity: 0, x: -100 }, { opacity: 1, x: 0, duration: 1 });}
            });
            ScrollTrigger.create({
                trigger: '.about-content',
                start: "top 80%",
                onEnter: () => { gsap.fromTo('.about-content', { opacity: 0, x: 100 }, { opacity: 1, x: 0, duration: 1 });}
            });
        }
    }

    document.querySelectorAll('a[href^="#"]').forEach(anchor => {
        anchor.addEventListener('click', function(e) {
            const targetId = this.getAttribute('href');
            if (targetId && targetId.length > 1 && targetId.startsWith('#')) {
                const targetElement = document.querySelector(targetId);
                if (targetElement) {
                    e.preventDefault();
                    const offsetTop = targetElement.offsetTop;
                    const headerOffset = document.querySelector('.header-area.sticky') ? 80 : 100;
                    window.scrollTo({
                        top: offsetTop - headerOffset,
                        behavior: 'smooth'
                    });
                }
            } else if (targetId === '#') {
                e.preventDefault();
            }
        });
    });
});