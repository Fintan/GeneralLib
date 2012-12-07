/*global module:false*/
module.exports = function(grunt) {

	// Project configuration.
	grunt.initConfig({
		meta: {
			version: '0.1.0',
			banner: '/*! General library for multi-platform development - v<%= meta.version %> - ' + '<%= grunt.template.today("yyyy-mm-dd") %>\n' + '* http://PROJECT_WEBSITE/\n' + '* Copyright (c) <%= grunt.template.today("yyyy") %> ' + 'YOUR_NAME; Licensed MIT */'
		},
		lint: {
			files: ['grunt.js']
		},
		concat: {
			GeneralLibTests: {
				src: ['resources/js/*.js', 'dist/GeneralLibTests.js'],
				dest: 'dist/GeneralLibTests.js'
			}
		},
		min: {
			GeneralLibTests: {
				src: ['<banner:meta.banner>', '<config:concat.GeneralLibTests.dest>'],
				dest: 'dist/GeneralLibTests.js'
			}
		},
		jshint: {
			options: {
				curly: true,
				eqeqeq: true,
				immed: true,
				latedef: true,
				newcap: true,
				noarg: true,
				sub: true,
				undef: true,
				boss: true,
				eqnull: true,
				browser: true
			},
			globals: {}
		},
		uglify: {},
		clean: ["dist/*", "compiled/*"],
		copy: {
			dist: {
				files: {
					"dist/": "resources/html/**"
				}
			}
		},
		watch:{
			files: 'src/**/*.hx',
			tasks: ['hx']
		},
		haxe: {
			sketches: {
				main:'GeneralLibTests',
				classpath: ['src', 'libs'],
				libs:['utest'],
				misc:["--js-modern"],
				output: {
					GeneralLibTests: {
						output: 'dist/GeneralLibTests.js'
					},
					GeneralLibTestsFl: {
						output: 'dist/GeneralLibTests.swf'
					}
				}
			}
		}
	});

	grunt.loadNpmTasks('grunt-haxe');
	grunt.loadNpmTasks('grunt-contrib-clean');
	grunt.loadNpmTasks('grunt-contrib-copy');
	// Default task.
	grunt.registerTask('default', 'hx');
	grunt.registerTask('hx', 'clean copy:dist haxe:sketches concat');

};
