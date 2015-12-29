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
        modulesDirectories: ["./src", "./node_modules"]
    },
    entry: './src/app.jsx',
    output: {
        path: '../public/build/',
        publicPath: '/build/',
        filename: '[name].js'
    },
    module: {
        loaders: [
            { test: /\.(s)?css$/, loader: ExtractTextPlugin.extract('style-loader', sassLoaders.join("!")) },
            {
              test: /\.jsx?$/,
              exclude: /(node_modules|bower_components)/,
              loader: 'babel',
              query: { presets: ['react', 'es2015'] } },
        ]
    },
    plugins: [
        new ExtractTextPlugin("[name].css"),
    ],
    stats: {
        colors: true
    },
    devtool: 'source-map',
    keepalive: true
};
