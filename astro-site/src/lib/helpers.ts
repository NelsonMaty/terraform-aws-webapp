export function trimText(input: string, maxLength: number = 100): string {
  if (input.length <= maxLength) return input;
  return input.substring(0, maxLength - 3) + "...";
}
export function getCurrentTimeInItaly(): Date {
  // Create a date object with the current UTC time
  const now = new Date();

  // Convert the UTC time to Argentina's time
  const offsetArgentina = -3; // Argentina is in ART (UTC-3)
  now.setHours(now.getUTCHours() + offsetArgentina);

  return now;
}

export function formatTimeForItaly(date: Date): string {
  const options: Intl.DateTimeFormatOptions = {
    hour: "numeric",
    minute: "2-digit",
    second: "2-digit",
    hour12: true,
    timeZone: "America/Argentina/Buenos_Aires",
  };

  let formattedTime = new Intl.DateTimeFormat("en-US", options).format(date);

  // Append the time zone abbreviation
  formattedTime += " ART";

  return formattedTime;
}

export function formatDate(date: Date): string {
  return date.toLocaleDateString("en-US", {
    year: "numeric",
    month: "long",
    day: "numeric",
  });
}
