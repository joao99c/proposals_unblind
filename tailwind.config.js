module.exports = {
    content: [
        './app/views/**/*.html.erb',
        './app/helpers/**/*.rb',
        './app/assets/stylesheets/**/*.css',
        './app/javascript/**/*.js',
    ],
    // make sure to safelist these classes when using purge
    safelist: [
        'container-sm',
        'max-w-[100%]',
        'w-64',
        'w-80',
        'w-1/2',
        'rounded-l-lg',
        'rounded-r-lg',
        'bg-gray-200',
        'grid-cols-4',
        'grid-cols-7',
        'h-6',
        'leading-6',
        'h-9',
        'leading-9',
        'shadow-lg',
        'bg-opacity-50',
        'dark:bg-opacity-80',

        // Safe list bagde colors
        'text-red-600',
        'dark:text-red-500',
        '!m-1',
        '!ml-0',
        'gap-2',
        '!text-gray-800',
        '!text-red-800',
        '!text-yellow-800',
        '!text-green-800',
        '!text-blue-800',
        '!text-indigo-800',
        '!text-purple-800',
        '!text-pink-800',
        'bg-red-100',
        '!bg-gray-100',
        '!bg-red-100',
        '!bg-yellow-100',
        '!bg-green-100',
        '!bg-blue-100',
        '!bg-indigo-100',
        '!bg-purple-100',
        '!bg-pink-100',
        'bg-green-100',
        'bg-purple-100',
        'text-red-800',
        'text-green-800',
        'text-purple-800',
        'dark:bg-red-200',
        'dark:bg-green-200',
        'dark:bg-purple-200',
        'dark:text-red-900',
        'dark:text-green-900',
        'dark:text-purple-900',
    ],
    theme: {
        extend: {
            screens: {
                'xs': '364px',
            },
            transitionProperty: {
                'max-width': 'max-width'
            },
            fontFamily: {
                'sans': 'Inter',
            }
        },
    },

    plugins: [
        require("flowbite/plugin"),
        require("@thoughtbot/tailwindcss-aria-attributes")
    ],
}
