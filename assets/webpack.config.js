const webpack = require("webpack");
const ExtractTextPlugin = require("extract-text-webpack-plugin");
const path = require('path');

const sassLoaders = [
  "css-loader",
  "sass-loader?includePaths[]=" + path.resolve(__dirname, "./src"),
];

module.exports = {
    resolve: {
        extensions: ['', '.js', '.jsx', '.scss'],
        modulesDirectories: ["./src", "../node_modules"]
    },
    entry: './src/app.js',
    output: {
        path: '../public/build/',
        publicPath: '/build/',
        filename: '[name].js'
    },
    module: {
        loaders: [
            { test: /\.(s)?css$/, loader: ExtractTextPlugin.extract('style-loader', sassLoaders.join("!")) },
            { test: /\.js(x)?$/, loader: require.resolve('babel-loader') },
        ]
    },
    plugins: [
        new ExtractTextPlugin("[name].css"),
    ],
    stats: {
        colors: true
    },
    devtool: 'source-map',
    watch: true,
    keepalive: true
};
