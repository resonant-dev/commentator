module.exports = {
    purge: ['./index.html', './src/**/*.{js,ts,jsx,tsx}'],
    darkMode: false, // or 'media' or 'class'
    prefix: 'ct-',
    important: '#commentator',
    theme: {
        extend: {},
    },
    variants: {
        extend: {},
    },
    plugins: [require('@tailwindcss/forms')],
};
