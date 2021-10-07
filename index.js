//selectors
const mobileMenu = document.querySelector('#mobile__menu');
const navMenu = document.querySelector('.navbar__menu');

//function
const addNavMobileMenu =() => {
    // console.log('hello');
    navMenu.classList.toggle('active');
};
//eventLinstener
mobileMenu.addEventListener('click', addNavMobileMenu);
