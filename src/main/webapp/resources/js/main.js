document.addEventListener('DOMContentLoaded', function() {
    'use strict';

    const preloader = document.getElementById('preloader');
    const header = document.querySelector('.header-area');
    let animationsInitialized = false;
    const heroAreaElement = document.querySelector('.hero-area');
    const tsparticlesContainerId = "tsparticles-background";
    let tsParticlesInstanceLoaded = false;

    function initializePageAnimations() {
        if (animationsInitialized) return;
        if (typeof AOS !== 'undefined') {
            AOS.init({
                duration: 800,
                once: true,
                easing: 'ease-in-out'
            });
        }
        if (typeof gsap !== 'undefined' && document.querySelector('.hero-text-animated')) {
            triggerHeroAnimation();
        }
        initializeScrollTriggers();
        animationsInitialized = true;
    }

    if (preloader) {
        let preloaderDone = false;
        const hidePreloader = () => {
            if (preloaderDone) return;
            preloader.classList.add('hiding');
            setTimeout(() => {
                preloader.classList.add('loaded');
                initializePageAnimations();
                preloaderDone = true;
            }, 400);
        };
        window.addEventListener('load', () => {
            setTimeout(hidePreloader, 500);
        });
        setTimeout(() => {
            if (!preloader.classList.contains('loaded')) {
                hidePreloader();
            }
        }, 8000);
    } else {
        initializePageAnimations();
    }

    if (header) {
        const debounce = (func, wait) => {
            let timeout;
            return function executedFunction(...args) {
                const later = () => {
                    clearTimeout(timeout);
                    func(...args);
                };
                clearTimeout(timeout);
                timeout = setTimeout(later, wait);
            };
        };
        const handleScroll = () => {
            if (window.scrollY > 100) {
                header.classList.add('sticky');
            } else {
                header.classList.remove('sticky');
            }
        };
        window.addEventListener('scroll', debounce(handleScroll, 50));
    }

    function triggerHeroAnimation() {
        if (document.querySelector('.hero-text-animated')) {
            const heroTimeline = gsap.timeline({ delay: 0.3 });
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

    function initializeScrollTriggers() {
        if (typeof gsap !== 'undefined' && typeof ScrollTrigger !== 'undefined') {
            gsap.utils.toArray('.section-title').forEach(title => {
                ScrollTrigger.create({
                    trigger: title,
                    start: "top 80%",
                    once: true,
                    onEnter: () => { gsap.fromTo(title, { y: 100, opacity: 0 }, { y: 0, opacity: 1, duration: 0.8, ease: 'power2.out' }); }
                });
            });
            gsap.utils.toArray('.feature-box').forEach((box, index) => {
                ScrollTrigger.create({
                    trigger: box,
                    start: "top 80%",
                    once: true,
                    onEnter: () => { gsap.fromTo(box, { y: 100, opacity: 0 }, { y: 0, opacity: 1, duration: 0.6, delay: index * 0.1, ease: 'power2.out' }); }
                });
            });
            if (document.querySelector('.skill-progress-bar')) {
                const skillBars = document.querySelectorAll('.skill-progress-bar');
                ScrollTrigger.create({
                    trigger: '.skills-area',
                    start: "top 75%",
                    once: true,
                    onEnter: () => {
                        skillBars.forEach(skill => {
                            const percent = skill.getAttribute('data-progress');
                            if (percent) {
                                gsap.to(skill, { width: percent, duration: 1.5, ease: "power3.out" });
                            }
                        });
                    }
                });
            }
            if (document.querySelector('.timeline-item')) {
                gsap.utils.toArray('.timeline-item').forEach((item, index) => {
                    ScrollTrigger.create({
                        trigger: item,
                        start: "top 80%",
                        once: true,
                        onEnter: () => { gsap.fromTo(item, { opacity: 0, x: index % 2 === 0 ? -50 : 50 }, { opacity: 1, x: 0, duration: 0.8, ease: 'power2.out' }); }
                    });
                });
            }
            if (document.querySelector('.testimonial-item')) {
                gsap.utils.toArray('.testimonial-item').forEach((item, index) => {
                    ScrollTrigger.create({
                        trigger: item,
                        start: "top 80%",
                        once: true,
                        onEnter: () => { gsap.fromTo(item, { opacity: 0, y: 50 }, { opacity: 1, y: 0, duration: 0.7, delay: index * 0.1, ease: 'power2.out' }); }
                    });
                });
            }
            if (document.querySelector('.company-box')) {
                gsap.utils.toArray('.company-box').forEach((box) => {
                    ScrollTrigger.create({
                        trigger: box,
                        start: "top 80%",
                        once: true,
                        onEnter: () => { gsap.fromTo(box, { opacity: 0, y: 50 }, { opacity: 1, y: 0, duration: 0.7, ease: 'power2.out' }); }
                    });
                });
            }
            if (document.querySelector('.about-img') && document.querySelector('.about-content')) {
                ScrollTrigger.create({
                    trigger: '.about-area',
                    start: "top 70%",
                    once: true,
                    onEnter: () => {
                        gsap.fromTo('.about-img', { opacity: 0, x: -50 }, { opacity: 1, x: 0, duration: 1, ease: 'power2.out' });
                        gsap.fromTo('.about-content', { opacity: 0, x: 50 }, { opacity: 1, x: 0, duration: 1, delay: 0.2, ease: 'power2.out' });
                    }
                });
            }
        }
    }

    function loadAndInitTsParticles() {
        if (tsParticlesInstanceLoaded || !document.getElementById(tsparticlesContainerId) || typeof tsParticles === 'undefined') {
            if (!document.getElementById(tsparticlesContainerId) && heroAreaElement) {
                console.warn(`Element with ID '${tsparticlesContainerId}' not found. tsParticles will not load for hero.`);
            }
            if (typeof tsParticles === 'undefined' && document.getElementById(tsparticlesContainerId)) {
                console.warn(`tsParticles library is not defined. Make sure it's included in your HTML.`);
            }
            return;
        }
        tsParticles.load(tsparticlesContainerId, {
            fpsLimit: 60,
            particles: {
                number: {
                    value: 35,
                    density: {
                        enable: true,
                        value_area: 950
                    }
                },
                color: { value: "#ffffff" },
                shape: { type: "circle" },
                opacity: {
                    value: 0.45,
                    random: true,
                    anim: { enable: false }
                },
                size: {
                    value: 1.6,
                    random: true,
                    anim: { enable: false }
                },
                links: {
                    enable: true,
                    distance: 115,
                    color: "#ffffff",
                    opacity: 0.3,
                    width: 1
                },
                move: {
                    enable: true,
                    speed: 0.7,
                    direction: "none",
                    random: true,
                    straight: false,
                    out_mode: "out",
                    attract: { enable: false }
                }
            },
            interactivity: {
                detect_on: "parent",
                events: {
                    onhover: {
                        enable: true,
                        mode: "grab"
                    },
                    onclick: { enable: false },
                    resize: true
                },
                modes: {
                    grab: {
                        distance: 130,
                        links: { opacity: 0.4 }
                    },
                    repulse: {
                        distance: 40,
                        duration: 0.4
                    }
                }
            },
            detectRetina: false
        }).then(container => {
            tsParticlesInstanceLoaded = true;
        }).catch(error => {
            console.error("tsParticles load error:", error);
        });
    }

    if (heroAreaElement && typeof IntersectionObserver !== 'undefined' && IntersectionObserver) {
        const observerOptions = {
            rootMargin: '100px 0px',
            threshold: 0.01
        };
        const particleObserver = new IntersectionObserver((entries, observer) => {
            entries.forEach(entry => {
                if (entry.isIntersecting) {
                    loadAndInitTsParticles();
                    observer.unobserve(entry.target);
                }
            });
        }, observerOptions);
        particleObserver.observe(heroAreaElement);
    } else {
        if (heroAreaElement) { // Only load with delay if hero area exists
            setTimeout(loadAndInitTsParticles, 1500);
        }
    }

    document.querySelectorAll('a[href^="#"]').forEach(anchor => {
        anchor.addEventListener('click', function(e) {
            const targetId = this.getAttribute('href');
            if (targetId && targetId.length > 1 && targetId.startsWith('#')) {
                const targetElement = document.querySelector(targetId);
                if (targetElement) {
                    e.preventDefault();
                    let headerOffset = 100;
                    if (header && header.classList.contains('sticky')) {
                        headerOffset = 80;
                    } else if (header && header.offsetHeight > 0) {
                        headerOffset = header.offsetHeight + 20;
                    }
                    const elementPosition = targetElement.getBoundingClientRect().top + window.pageYOffset;
                    const offsetPosition = elementPosition - headerOffset;
                    window.scrollTo({
                        top: offsetPosition,
                        behavior: 'smooth'
                    });
                }
            } else if (targetId === '#') {
                e.preventDefault();
            }
        });
    });
});