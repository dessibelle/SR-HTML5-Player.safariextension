module.exports = (grunt) ->

    # Project configuration.
    grunt.initConfig
        pkg: grunt.file.readJSON('package.json'),

        coffee:
            main:
                files:
                    'player.js': ['src/coffee/player.coffee']

        less:
            main:
                options:
                    paths: ["less"],
                    yuicompress: true
                files:
                    "player.css" : "src/less/player.less"

        # uglify:
        #     main:
        #         files: [
        #             'static/js/modernizr-2.6.2.min.js': ['libs/modernizr-2.6.2.js'],
        #         ]


        watch:
            watch:
                files: ['src/coffee/*.coffee', 'src/less/*.less'],
                tasks: ['default'],
                # options:
                #     nospawn: true


    grunt.loadNpmTasks('grunt-contrib-less');
    grunt.loadNpmTasks('grunt-contrib-coffee');
    grunt.loadNpmTasks('grunt-contrib-watch');
    # grunt.loadNpmTasks('grunt-contrib-concat');
    # grunt.loadNpmTasks('grunt-contrib-uglify');

    grunt.registerTask('default', ['less', 'coffee'])
    # grunt.registerTask('dist', ['default', 'concat', 'uglify'])

