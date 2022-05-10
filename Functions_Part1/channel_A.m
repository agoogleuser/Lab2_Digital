function [output_t, output_f] = channel_A(printCHannelInfo, BW, frequencyRange, varargin)

  symbolVector_t = varargin{1}; %%one variable
  inputLength = length(varargin{1});
  if (nargin >= 2) %%two or more variables
    for i=2:(nargin-4)
      %Check if the input size is the same for each vector input.
      if (length(varargin{i}) ~= inputLength)
        error("Invalid size for input vectors");
      end

      %Merge the vectors into a single big vector.
      symbolVector_t =  symbolVector_t+varargin{i};
    end
  end

  %Creating Filter Response
  [~, F_end]   = min(abs(frequencyRange-BW));   %nearest index of +BW
  [~, F_start] = min(abs(frequencyRange+BW));   %nearest index of -BW
  Ns = length(frequencyRange);
  filter = [zeros(1,F_start) ones(1,F_end - F_start-1) zeros(1, Ns - F_end+1) ];

  %Plotting Filter Response
  if (printCHannelInfo == true)
    figure;
    plot(frequencyRange, filter);
    title("Band Limited Channel Frequency Impulse Response");
    grid on
    xlim([-200e3 200e3])
    ylim([0 1.5])
    xlabel("frequency (f)");
    ylabel("Amplitude (v)");
  end

   %Affecting the input signals with the channel's response
  symbolVector_f = fftshift(fft(symbolVector_t));
  output_f = symbolVector_f .* filter;
  output_t = ifft(ifftshift(output_f));
end
