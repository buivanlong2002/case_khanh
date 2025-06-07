document.addEventListener('DOMContentLoaded', function() {
    'use strict';

    const preloader = document.getElementById('preloader');

    if (preloader) {
        window.addEventListener('load', function() {
            const hideDelay = 500;
            setTimeout(function() {
                preloader.classList.add('hiding');
                setTimeout(function() {
                    preloader.classList.add('loaded');
                    if (typeof AOS !== 'undefined') {
                        AOS.refreshHard();
                    }
                    if (typeof gsap !== 'undefined' && document.querySelector('.hero-text-animated')) {
                        triggerHeroAnimation();
                    }
                }, 400);
            }, hideDelay);
        });

        const fallbackTimeoutDuration = 8000;
        setTimeout(function() {
            if (!preloader.classList.contains('loaded')) {
                if (!preloader.classList.contains('hiding')) {
                    preloader.classList.add('hiding');
                    setTimeout(function() {
                        preloader.classList.add('loaded');
                        if (typeof AOS !== 'undefined') AOS.refreshHard();
                        if (typeof gsap !== 'undefined' && document.querySelector('.hero-text-animated')) {
                            triggerHeroAnimation();
                        }
                    }, 400);
                } else if (!preloader.classList.contains('loaded')) {
                    preloader.classList.add('loaded');
                    if (typeof AOS !== 'undefined') AOS.refreshHard();
                    if (typeof gsap !== 'undefined' && document.querySelector('.hero-text-animated')) {
                        triggerHeroAnimation();
                    }
                }
            }
        }, fallbackTimeoutDuration);
    } else {
        if (typeof gsap !== 'undefined' && document.querySelector('.hero-text-animated')) {
            triggerHeroAnimation();
        }
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
            duration: 800,
            once: true,
            easing: 'ease-in-out'
        });
    }

    function triggerHeroAnimation() {
        if (document.querySelector('.hero-text-animated')) {
            const heroTimeline = gsap.timeline({
                delay: 0.3
            });

            const nameWords = gsap.utils.toArray('.animated-name .name-word');

            nameWords.forEach((word, wordIndex) => {
                const chars = word.querySelectorAll('.char');
                heroTimeline.to(chars, {
                    opacity: 1,
                    y: '0%',
                    rotateZ: 0,
                    stagger: 0.1,
                    duration: 1,
                    ease: 'power3.out'
                }, wordIndex * 0.4);
            });

            heroTimeline.to('.animated-subtitle', {
                opacity: 1,
                y: 0,
                duration: 1.2,
                ease: 'power2.out'
            }, "-=0.6");

            heroTimeline.to('.hero-text-animated .hero-btns', {
                opacity: 1,
                y: 0,
                duration: 1.2,
                ease: 'power2.out'
            }, "-=0.8");
        }
    }

    if (typeof gsap !== 'undefined' && typeof ScrollTrigger !== 'undefined') {
        if (!preloader || preloader.classList.contains('loaded')) {
            if (document.querySelector('.hero-text-animated')) {
                triggerHeroAnimation();
            }
        }

        gsap.utils.toArray('.section-title').forEach(title => {
            ScrollTrigger.create({
                trigger: title,
                start: "top 80%",
                onEnter: () => { gsap.fromTo(title, { y: 100, opacity: 0 }, { y: 0, opacity: 1, duration: 0.8 }); }
            });
        });

        gsap.utils.toArray('.feature-box').forEach((box, index) => {
            ScrollTrigger.create({
                trigger: box,
                start: "top 80%",
                onEnter: () => { gsap.fromTo(box, { y: 100, opacity: 0 }, { y: 0, opacity: 1, duration: 0.6, delay: index * 0.15 });}
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

    if (document.getElementById('tsparticles-background') && typeof tsParticles !== 'undefined') {
        tsParticles.load("tsparticles-background", {
            fpsLimit: 60,
            particles: {
                number: {
                    value: 80,
                    density: {
                        enable: true,
                        value_area: 800
                    }
                },
                color: {
                    value: "#ffffff"
                },
                shape: {
                    type: "circle"
                },
                opacity: {
                    value: 0.5,
                    random: true,
                    anim: {
                        enable: true,
                        speed: 0.5,
                        opacity_min: 0.1,
                        sync: false
                    }
                },
                size: {
                    value: 2,
                    random: true,
                    anim: {
                        enable: false,
                        speed: 20,
                        size_min: 0.1,
                        sync: false
                    }
                },
                links: {
                    enable: true,
                    distance: 120,
                    color: "#ffffff",
                    opacity: 0.3,
                    width: 1
                },
                move: {
                    enable: true,
                    speed: 1.5,
                    direction: "none",
                    random: true,
                    straight: false,
                    out_mode: "out",
                    attract: {
                        enable: false,
                        rotateX: 600,
                        rotateY: 1200
                    }
                }
            },
            interactivity: {
                detect_on: "canvas",
                events: {
                    onhover: {
                        enable: true,
                        mode: "repulse"
                    },
                    onclick: {
                        enable: false,
                        mode: "push"
                    },
                    resize: true
                },
                modes: {
                    grab: {
                        distance: 200,
                        line_linked: {
                            opacity: 0.8
                        }
                    },
                    bubble: {
                        distance: 250,
                        size: 20,
                        duration: 2,
                        opacity: 0.8,
                        speed: 3
                    },
                    repulse: {
                        distance: 100,
                        duration: 0.4
                    },
                    push: {
                        particles_nb: 4
                    },
                    remove: {
                        particles_nb: 2
                    }
                }
            },
            detectRetina: true
        }).then(container => {
        }).catch(error => {
        });
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