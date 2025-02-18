/**
 * A higher-order function that wraps an asynchronous function and catches any errors that occur,
 * passing them to the next middleware in the request-response cycle.
 *
 * @param {Function} fn - The asynchronous function to be wrapped.
 * @returns {Function} - A new function that wraps the original function with error handling.
 */
const catchAsync = (fn) => {
  const errorHandler = (req, res, next) => {
    fn(req, res, next).catch(next);
  };

  return errorHandler;
};

module.exports = catchAsync;
